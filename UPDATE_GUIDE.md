# 🔄 Guide de Mise à Jour - MyPharm Auto-Update

Ce guide explique comment publier une nouvelle version de MyPharm pour que le système de mise à jour automatique fonctionne.

## 📋 Processus de Publication d'une Nouvelle Version

### 1. Préparer la Nouvelle Version

1. **Créer le dossier `dist`** :
   - Construisez votre application (build)
   - Assurez-vous que le dossier `dist/` contient tous les fichiers nécessaires
   - Le dossier `dist/` doit contenir :
     - `myPharm.jar`
     - `lib/` (toutes les bibliothèques)
     - `myPharm.html` et autres fichiers nécessaires

2. **Créer le fichier ZIP** :
   - Créez un fichier ZIP nommé `MyPharm-X.Y.Z.zip` (remplacez X.Y.Z par la version)
   - Le ZIP doit contenir un dossier `dist/` à la racine
   - Structure du ZIP :
     ```
     MyPharm-7.2.5.zip
     └── dist/
         ├── myPharm.jar
         ├── lib/
         ├── myPharm.html
         └── ...
     ```

3. **Calculer le checksum SHA-256** :
   - Ouvrez PowerShell dans le dossier contenant le ZIP
   - Exécutez :
     ```powershell
     Get-FileHash -Path "MyPharm-7.2.5.zip" -Algorithm SHA256 | Format-List
     ```
   - Copiez la valeur `Hash` (en majuscules, sans espaces)

### 2. Mettre à Jour les Fichiers sur Vercel

#### A. Mettre à Jour `latest.json`

Ouvrez `mypharm-updates/latest.json` et modifiez :

```json
{
  "version": "7.2.5",                    // ⬅️ NOUVELLE VERSION
  "download_url": "https://mypharm-updates.vercel.app/files/MyPharm-7.2.5.zip",  // ⬅️ NOUVEAU ZIP
  "changelog": "https://mypharm-updates.vercel.app/changelog.txt",
  "release_date": "2025-01-02",          // ⬅️ DATE DE PUBLICATION
  "min_java_version": "11",
  "file_size": 45217894,                 // ⬅️ TAILLE DU FICHIER EN BYTES
  "checksum": "VOTRE_CHECKSUM_SHA256_ICI",  // ⬅️ CHECKSUM CALCULÉ
  "mandatory": false                      // true = mise à jour obligatoire
}
```

**Champs à modifier :**
- `version` : Nouveau numéro de version (ex: "7.2.5")
- `download_url` : URL du nouveau fichier ZIP
- `release_date` : Date de publication (format: YYYY-MM-DD)
- `file_size` : Taille du fichier ZIP en bytes
- `checksum` : Hash SHA-256 du fichier ZIP (en majuscules)
- `mandatory` : `true` pour forcer la mise à jour, `false` pour optionnel

#### B. Mettre à Jour le Changelog

Ouvrez `mypharm-updates/changelog.txt` et ajoutez la nouvelle version en haut :

```
=== Version 7.2.5 (02 Janvier 2025) ===
✨ NOUVEAUTÉS :
- Nouvelle fonctionnalité 1
- Nouvelle fonctionnalité 2

🐛 CORRECTIONS :
- Bug fix 1
- Bug fix 2

🔧 AMÉLIORATIONS :
- Amélioration 1
- Amélioration 2

=== Version 7.2.4 (02 Janvier 2025) ===
...
```

#### C. Ajouter le Fichier ZIP

1. Copiez le fichier ZIP dans `mypharm-updates/files/`
2. Nommez-le `MyPharm-X.Y.Z.zip` (même nom que dans `download_url`)

### 3. Mettre à Jour le Code Source (Optionnel mais Recommandé)

Dans `src/tools/AutoUpdateService.java`, ligne 16 :

```java
private static final String CURRENT_VERSION = "7.2.5";  // ⬅️ NOUVELLE VERSION
```

**Important :** Cette valeur doit correspondre à la version que vous construisez. Si vous construisez la version 7.2.5, mettez "7.2.5" ici.

### 4. Déployer sur Vercel

1. Commitez et poussez vos changements :
   ```bash
   git add .
   git commit -m "Release version 7.2.5"
   git push
   ```

2. Déployez sur Vercel :
   ```bash
   cd mypharm-updates
   vercel --prod
   ```
   
   Ou si vous avez configuré le déploiement automatique, Vercel déploiera automatiquement.

3. Vérifiez que les fichiers sont accessibles :
   - `https://mypharm-updates.vercel.app/latest.json`
   - `https://mypharm-updates.vercel.app/files/MyPharm-7.2.5.zip`
   - `https://mypharm-updates.vercel.app/changelog.txt`

### 5. Tester la Mise à Jour

1. **Test avec une ancienne version** :
   - Installez une version antérieure (ex: 7.2.4)
   - Lancez l'application
   - Le système devrait détecter la nouvelle version après 30 secondes
   - Cliquez sur "Vérifier les mises à jour" dans le menu pour tester immédiatement

2. **Vérifier** :
   - La notification de mise à jour s'affiche
   - Le dialog de mise à jour s'ouvre correctement
   - Le téléchargement fonctionne
   - L'installation remplace bien le dossier `dist`

## 🔍 Vérification Rapide

Pour vérifier que tout est configuré correctement :

1. Ouvrez dans un navigateur : `https://mypharm-updates.vercel.app/latest.json`
2. Vérifiez que :
   - La version est correcte
   - L'URL du ZIP est correcte et accessible
   - Le checksum correspond au fichier ZIP

## ⚠️ Notes Importantes

1. **Version numbering** : Utilisez le format `X.Y.Z` (ex: 7.2.4 → 7.2.5)
2. **Checksum** : Toujours en majuscules, sans espaces
3. **Structure ZIP** : Le ZIP doit contenir un dossier `dist/` à la racine
4. **File size** : En bytes (utilisez les propriétés du fichier)
5. **Déploiement** : Après chaque changement, déployez sur Vercel

## 🐛 Dépannage

**Le système ne détecte pas la nouvelle version ?**
- Vérifiez que `latest.json` est déployé correctement
- Vérifiez que la version dans `latest.json` est supérieure à `CURRENT_VERSION`
- Vérifiez que l'URL est accessible

**Erreur de checksum ?**
- Recalculez le checksum SHA-256
- Vérifiez que c'est en majuscules
- Vérifiez qu'il n'y a pas d'espaces

**L'installation échoue ?**
- Vérifiez que le ZIP contient bien un dossier `dist/` à la racine
- Vérifiez que les permissions du fichier sont correctes
- Vérifiez les logs de l'application


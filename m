Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FABC43458
	for <kexec@archiver.kernel.org>; Thu,  2 Jul 2026 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uQXwRfNx0b+cTHhdSx5J83FGDt8YDjF1iSoBNLo1Qfw=; b=Ly+FbF+b+uPcaL96WC/Jf9SkYv
	tZMoo3uovDpt9cVosda86i3lNLl2PLiJa0Il5+T2797MszN5uDGCACwZuDZnpGeoo/tjBBs1JTDWE
	sc87Y10LTIRw4ToJp3BTbo1xCEVrhFfibZPrH4yTK7ibdG3zbPEIjkrWqm6IVxB6NL4nBOJv3Gz0L
	+DfQvOgz2XMRTO3ZFu/L54+TH5F6swY2xtA6iXDOPeNelCOoMRbgtavsjMJWoICwcgCXzvPP66wBT
	5rbO4tY0e/YS1cA1rGcrwe+i3w1EA95FyppSL4h4N3X/sMczv4UTbLnB3b/wvKKveyUAbxByzYQLk
	lf97Jndw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLZN-00000005BC6-1eNB;
	Thu, 02 Jul 2026 17:51:25 +0000
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com ([44.246.68.102])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLZI-00000005BAp-2OdC
	for kexec@lists.infradead.org;
	Thu, 02 Jul 2026 17:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783014680; x=1814550680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uQXwRfNx0b+cTHhdSx5J83FGDt8YDjF1iSoBNLo1Qfw=;
  b=iHurieKct5guGRUltMiN6xLJQ2Mru3GBQOOE1xk6fA7Whl0CRtxRd6A4
   b/R/szYxM9j8ZDZ5ByV1z4V4Rkg0gdRIA1nE/8TsFaEZC3csSYWx1Izyk
   Oye8D3stAJjXAmORVAXky4WCuKWgfQHNHVetdzETiMCFJaBw10DoCNHql
   wEIaRcW54HjdPpWEiRFQSVj1IWNBnOIdKdcUutbRBRNGCqdzttkgTAY2u
   Cnig1j62KoT1aEaHoeDYdAmoG4OoyImGvlhBYQofIb4+IEALzI5ruLOX8
   XZr3ndqmZI6T/mxb6wF3yifKaSDoyjbwMCBG/sIzKuPELJcVPG5YRdJc+
   g==;
X-CSE-ConnectionGUID: dyk/pfW6R6C9ZTRGbm3/QQ==
X-CSE-MsgGUID: fnYdymBqRpG9CyA4KMDJnA==
X-IronPort-AV: E=Sophos;i="6.25,144,1779148800"; 
   d="scan'208";a="22963744"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 17:51:19 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:8808]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.125:2525] with esmtp (Farcaster)
 id d489353c-48c5-44c8-b75e-960692b706e6; Thu, 2 Jul 2026 17:51:19 +0000 (UTC)
X-Farcaster-Flow-ID: d489353c-48c5-44c8-b75e-960692b706e6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 2 Jul 2026 17:51:19 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 2 Jul 2026
 17:51:16 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tejun Heo
	<tj@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, "David
 Matlack" <dmatlack@google.com>, Samiullah Khawaja <skhawaja@google.com>,
	Alexander Graf <graf@amazon.com>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 05/14] driver core: add struct device_sysfs_entry and walker
Date: Thu, 2 Jul 2026 19:51:05 +0200
Message-ID: <20260702175114.24659-1-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702174033.32116-1-sakacpav@amazon.de>
References: <20260702174033.32116-1-sakacpav@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_105120_713279_80491589 
X-CRM114-Status: GOOD (  26.07  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Introduce the primitive for declaring per-device sysfs content as
table rows and a single walker that dispatches across eager,
lazy-populate, and teardown paths.

struct device_sysfs_entry { name, applies_to, create, remove }

  - name == NULL: wildcard row (create() does internal name
    dispatch; used for attribute_group-source rows).
  - applies_to: NULL or a pure, cheap, non-sleeping predicate.
  - create: implements ADD_ONE (name != NULL) and ADD_ALL
    (name == NULL) semantics; absorbs -EEXIST from concurrent
    racers to 0.
  - remove: reverse-order teardown.

device_sysfs_apply(dev, entries, action, name) dispatches
DEV_SYSFS_ADD_ONE / DEV_SYSFS_ADD_ALL / DEV_SYSFS_REMOVE_ALL across
the table. -ENOENT from a wildcard row's create() is treated as
"not my name" and the walker continues; any other error propagates
to the caller on ADD_ONE and is absorbed on ADD_ALL (best-effort).
REMOVE_ALL reverses the table and never aborts. The full contract
is documented in Documentation/driver-api/sysfs-lazy.rst (added
later in this series).

Shape follows cftype + cgroup_addrm_files (kernel/cgroup/cgroup.c)
as the in-tree precedent for table-driven attribute creation.
struct kobj_type grows a trailing .entries pointer; ktypes opt in
by setting it and wiring their populate / populate_all callbacks
to the walker. The field is at end of struct for source-
compatibility with positional initialisers of out-of-tree ktypes.

sysfs_add_file_mode_ns() and sysfs_add_bin_file_mode_ns() are
exported (kerneldoc added) so the walker can absorb -EEXIST from
concurrent create racers without going through sysfs_warn_dup().

Two static helpers - create_attr_in_groups() and
create_all_in_groups() - are added for use by attribute-group
source rows that the migration commit later wires up; they search
@groups by @name and walk every visible attribute respectively.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: driver-core@lists.linux.dev
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/base/core.c     | 319 ++++++++++++++++++++++++++++++++++++++++
 fs/sysfs/file.c         |  41 +++++-
 fs/sysfs/sysfs.h        |   6 -
 include/linux/device.h  |  56 +++++++
 include/linux/kobject.h |   5 +
 include/linux/sysfs.h   |  24 +++
 6 files changed, 443 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6d0d917d4b1ff..aeb4985eb8838 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2574,6 +2574,325 @@ static void device_release(struct kobject *kobj)
 	kfree(p);
 }
 
+/*
+ * device_sysfs_apply() - declarative per-device sysfs dispatch
+ *
+ * Single walker over a sentinel-terminated struct device_sysfs_entry
+ * table. Intended to be invoked on every dispatch path (device_add
+ * eager, lazy populate_one, lazy populate_all, device_del teardown)
+ * so adding a new per-device file is one row, not four open-coded
+ * branches. Shape follows cftype + cgroup_addrm_files
+ * (kernel/cgroup/cgroup.c) and pci_sysfs_entries[]
+ * (drivers/pci/pci-sysfs.c).
+ *
+ * ADD_ONE:  first row whose applies_to passes and whose name matches
+ *	     (or a wildcard row whose create() does not return
+ *	     -ENOENT) terminates the walk. -ENOENT from a wildcard
+ *	     row's create() signals "not my name"; the walker
+ *	     continues. Realize callbacks MUST check existence (via
+ *	     sysfs_*_exists()) before calling sysfs_create_*() and
+ *	     return 0 if the entry already exists. Reaching
+ *	     __kernfs_create_*() for a name that another lazy path
+ *	     just created is forbidden under lock
+ *	     serialization. If sysfs_warn_dup() ever fires from a
+ *	     lazy path, it indicates a lock invariant
+ *	     violation or a non-lazy path creating lazy attrs (bug).
+ * ADD_ALL:  every applicable row's create() fires with name = NULL;
+ *	     per-row errors are best-effort - the walker discards
+ *	     return values and rows log via their own diagnostics.
+ * REMOVE_ALL: reverse row order; remove() fires for every row whose
+ *	     applies_to passes. Teardown never aborts.
+ *
+ * The full walker contract (error-absorption matrix, interaction
+ * with negative-dentry caching, lifecycle caveats) is documented in
+ * Documentation/driver-api/sysfs-lazy.rst, added later in this
+ * series.
+ */
+/*
+ * Create one named attr inside @grp; honours grp->is_visible.
+ * Returns 0 on success/hidden/already-present, -ENOENT on no-match.
+ */
+static int create_attr_in_group(struct device *dev,
+				 const struct attribute_group *grp,
+				 const char *name)
+{
+	struct attribute **a;
+	const struct bin_attribute *const *ba;
+	kuid_t uid;
+	kgid_t gid;
+	umode_t mode;
+	int i;
+
+	if (device_is_sysfs_lazy(dev))
+		lockdep_assert_held(&dev->sysfs_lazy->lock);
+
+	kobject_get_ownership(&dev->kobj, &uid, &gid);
+
+	if (grp->name) {
+		if (!strcmp(grp->name, name)) {
+			if (sysfs_group_exists(&dev->kobj, grp))
+				return 0;
+			return sysfs_create_group(&dev->kobj, grp);
+		}
+		return -ENOENT;
+	}
+
+	if (grp->attrs) {
+		for (i = 0, a = grp->attrs; *a; i++, a++) {
+			if (strcmp((*a)->name, name))
+				continue;
+
+			mode = (*a)->mode;
+			if (grp->is_visible || grp->is_visible_const) {
+				if (grp->is_visible)
+					mode = grp->is_visible(&dev->kobj, *a, i);
+				else
+					mode = grp->is_visible_const(&dev->kobj, *a, i);
+				mode &= ~SYSFS_GROUP_INVISIBLE;
+				if (!mode)
+					return 0;	/* hidden */
+			}
+			mode &= SYSFS_PREALLOC | 0664;
+
+			if (sysfs_kn_exists(&dev->kobj, (*a)->name))
+				return 0;
+
+			return sysfs_add_file_mode_ns(dev->kobj.sd, *a,
+						      mode, uid, gid, NULL);
+		}
+	}
+	if (grp->bin_attrs) {
+		for (i = 0, ba = grp->bin_attrs; *ba; i++, ba++) {
+			if (strcmp((*ba)->attr.name, name))
+				continue;
+			mode = (*ba)->attr.mode;
+			if (grp->is_bin_visible) {
+				mode = grp->is_bin_visible(&dev->kobj, *ba, i);
+				mode &= ~SYSFS_GROUP_INVISIBLE;
+				if (!mode)
+					return 0;
+			}
+			mode &= SYSFS_PREALLOC | 0664;
+
+			if (sysfs_kn_exists(&dev->kobj, (*ba)->attr.name))
+				return 0;
+
+			return sysfs_add_bin_file_mode_ns(dev->kobj.sd,
+							  *ba, mode,
+							  (*ba)->size,
+							  uid, gid, NULL);
+		}
+	}
+	return -ENOENT;
+}
+
+/*
+ * Per-group incremental creation. Tolerates partial state from
+ * concurrent populate_one. Best-effort: absorbs per-attr failures.
+ */
+static int create_group_incremental(struct device *dev,
+				     const struct attribute_group *grp)
+{
+	struct attribute **a;
+	const struct bin_attribute *const *ba;
+	int ret;
+
+	if (device_is_sysfs_lazy(dev))
+		lockdep_assert_held(&dev->sysfs_lazy->lock);
+
+	if (grp->name) {
+		struct kernfs_node *subdir;
+		kuid_t uid;
+		kgid_t gid;
+		umode_t mode;
+		int i;
+
+		subdir = kernfs_find_and_get(dev->kobj.sd, grp->name);
+		if (!subdir)
+			return sysfs_create_group(&dev->kobj, grp);
+
+		kobject_get_ownership(&dev->kobj, &uid, &gid);
+
+		if (grp->attrs) {
+			for (i = 0, a = grp->attrs; *a; i++, a++) {
+				struct kernfs_node *kn;
+
+				mode = (*a)->mode;
+				if (grp->is_visible || grp->is_visible_const) {
+					if (grp->is_visible)
+						mode = grp->is_visible(&dev->kobj,
+								       *a, i);
+					else
+						mode = grp->is_visible_const(&dev->kobj,
+									     *a, i);
+					mode &= ~SYSFS_GROUP_INVISIBLE;
+					if (!mode)
+						continue;
+				}
+				mode &= SYSFS_PREALLOC | 0664;
+
+				/* Existence check inside named @subdir (not a kobject). */
+				kn = kernfs_find_and_get(subdir, (*a)->name);
+				if (kn) {
+					kernfs_put(kn);
+					continue;
+				}
+
+				ret = sysfs_add_file_mode_ns(subdir, *a,
+							     mode, uid,
+							     gid, NULL);
+				if (ret)
+					dev_dbg(dev,
+						"lazy %s/%s: %d\n",
+						grp->name, (*a)->name, ret);
+			}
+		}
+		if (grp->bin_attrs) {
+			for (i = 0, ba = grp->bin_attrs; *ba; i++, ba++) {
+				struct kernfs_node *kn;
+
+				mode = (*ba)->attr.mode;
+				if (grp->is_bin_visible) {
+					mode = grp->is_bin_visible(&dev->kobj,
+								   *ba, i);
+					mode &= ~SYSFS_GROUP_INVISIBLE;
+					if (!mode)
+						continue;
+				}
+				mode &= SYSFS_PREALLOC | 0664;
+
+				kn = kernfs_find_and_get(subdir, (*ba)->attr.name);
+				if (kn) {
+					kernfs_put(kn);
+					continue;
+				}
+
+				ret = sysfs_add_bin_file_mode_ns(subdir,
+								 *ba,
+								 mode,
+								 (*ba)->size,
+								 uid,
+								 gid,
+								 NULL);
+				if (ret)
+					dev_dbg(dev,
+						"lazy %s/%s: %d\n",
+						grp->name,
+						(*ba)->attr.name, ret);
+			}
+		}
+
+		kernfs_put(subdir);
+		return 0;
+	}
+
+	if (grp->attrs) {
+		for (a = grp->attrs; *a; a++)
+			(void)create_attr_in_group(dev, grp, (*a)->name);
+	}
+	if (grp->bin_attrs) {
+		for (ba = grp->bin_attrs; *ba; ba++)
+			(void)create_attr_in_group(dev, grp,
+						    (*ba)->attr.name);
+	}
+	return 0;
+}
+
+/* Search @groups for @name. -ENOENT = not in this source. */
+static int __maybe_unused create_attr_in_groups(struct device *dev,
+				  const struct attribute_group *const *groups,
+				  const char *name)
+{
+	const struct attribute_group *const *g;
+	int ret;
+
+	if (!groups)
+		return -ENOENT;
+
+	for (g = groups; *g; g++) {
+		ret = create_attr_in_group(dev, *g, name);
+		if (ret != -ENOENT)
+			return ret;
+	}
+	return -ENOENT;
+}
+
+/* Walk @groups creating every visible attribute. Best-effort. */
+static int __maybe_unused create_all_in_groups(struct device *dev,
+				 const struct attribute_group *const *groups)
+{
+	const struct attribute_group *const *g;
+
+	if (!groups)
+		return 0;
+
+	for (g = groups; *g; g++)
+		(void)create_group_incremental(dev, *g);
+	return 0;
+}
+
+static const struct device_sysfs_entry *
+device_sysfs_entries_end(const struct device_sysfs_entry *entries)
+{
+	const struct device_sysfs_entry *e = entries;
+
+	while (e->create)
+		e++;
+	return e;
+}
+
+static __maybe_unused int
+device_sysfs_apply(struct device *dev,
+		  const struct device_sysfs_entry *entries,
+		  enum dev_sysfs_action action, const char *name)
+{
+	const struct device_sysfs_entry *e;
+
+	if (!entries)
+		return action == DEV_SYSFS_ADD_ONE ? -ENOENT : 0;
+
+	if (action == DEV_SYSFS_REMOVE_ALL) {
+		for (e = device_sysfs_entries_end(entries) - 1;
+		     e >= entries; e--) {
+			if (e->applies_to && !e->applies_to(dev))
+				continue;
+			if (e->remove)
+				e->remove(dev);
+		}
+		return 0;
+	}
+
+	for (e = entries; e->create; e++) {
+		int ret;
+
+		if (e->applies_to && !e->applies_to(dev))
+			continue;
+		if (action == DEV_SYSFS_ADD_ONE && e->name &&
+		    strcmp(e->name, name))
+			continue;
+
+		ret = e->create(dev, action == DEV_SYSFS_ADD_ONE
+					      ? name : NULL);
+		if (action == DEV_SYSFS_ADD_ONE) {
+			/*
+			 * A named row is the authoritative handler for its
+			 * name: return its result even on -ENOENT. A wildcard
+			 * row (e->name == NULL) may decline with -ENOENT, so
+			 * keep scanning for another handler in that case.
+			 */
+			if (e->name || ret != -ENOENT)
+				return ret;
+		}
+		/*
+		 * FIXME: ADD_ALL is best-effort and never returns the first create() failure to
+		 * the caller, so device_ktype_populate_all() latches populated=true after a
+		 * transient failure - the missing attribute is negative-cached forever (a later
+		 * lookup returns -ENOENT and never retries), contradicting the sysfs-lazy ABI.
+		 */
+	}
+	return action == DEV_SYSFS_ADD_ONE ? -ENOENT : 0;
+}
+
 static const struct ns_common *device_namespace(const struct kobject *kobj)
 {
 	const struct device *dev = kobj_to_dev(kobj);
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 5f3144e52ab72..8d0b8c2c2ee4d 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -270,6 +270,25 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap = {
 	.llseek		= sysfs_kf_bin_llseek,
 };
 
+/**
+ * sysfs_add_file_mode_ns - create a sysfs attribute file under @parent
+ * @parent: kernfs node for the parent directory (typically @kobj->sd)
+ * @attr:   attribute descriptor; @attr->name is the file name
+ * @mode:   file mode (low bits) optionally OR'd with %SYSFS_PREALLOC
+ * @uid: file owner UID
+ * @gid: file owner GID
+ * @ns:  namespace tag (may be %NULL)
+ *
+ * Picks a kernfs_ops dispatch row from (prealloc?, has show, has store)
+ * routing read()/write() through @parent->priv->ktype->sysfs_ops.
+ *
+ * Return: 0 on success, or -errno. -EEXIST means the name already
+ * exists and is treated as a caller error (it triggers sysfs_warn_dup()).
+ * The lazy populate path must not reach this: it checks sysfs_kn_exists()/
+ * sysfs_group_exists() under the populate lock before creating, so a
+ * concurrent ADD_ONE/ADD_ALL race resolves to a no-op rather than a
+ * duplicate create.
+ */
 int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 		const struct attribute *attr, umode_t mode, kuid_t uid,
 		kgid_t gid, const struct ns_common *ns)
@@ -320,6 +339,26 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 	return 0;
 }
 
+/**
+ * sysfs_add_bin_file_mode_ns - create a sysfs binary-attribute file
+ * @parent: kernfs node for the parent directory
+ * @battr:  binary attribute descriptor
+ * @mode:   file mode (low bits)
+ * @size:   in-core size of the binary attribute (passed to __kernfs_create_file())
+ * @uid: file owner UID
+ * @gid: file owner GID
+ * @ns:  namespace tag (may be %NULL)
+ *
+ * Picks a kernfs_ops dispatch row from a 5-row matrix on @battr's
+ * callbacks (mmap > rw > read > write > empty).
+ *
+ * Return: 0 on success, or -errno. -EEXIST means the name already
+ * exists and is treated as a caller error (it triggers sysfs_warn_dup()).
+ * The lazy populate path must not reach this: it checks sysfs_kn_exists()/
+ * sysfs_group_exists() under the populate lock before creating, so a
+ * concurrent ADD_ONE/ADD_ALL race resolves to a no-op rather than a
+ * duplicate create.
+ */
 int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
 		const struct bin_attribute *battr, umode_t mode, size_t size,
 		kuid_t uid, kgid_t gid, const struct ns_common *ns)
@@ -816,5 +855,3 @@ ssize_t sysfs_bin_attr_simple_read(struct file *file, struct kobject *kobj,
 	return count;
 }
 EXPORT_SYMBOL_GPL(sysfs_bin_attr_simple_read);
-
-
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index f4583dcafcd1e..94b8aca20bffc 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -27,12 +27,6 @@ void sysfs_warn_dup(struct kernfs_node *parent, const char *name);
 /*
  * file.c
  */
-int sysfs_add_file_mode_ns(struct kernfs_node *parent,
-		const struct attribute *attr, umode_t amode, kuid_t uid,
-		kgid_t gid, const struct ns_common *ns);
-int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
-		const struct bin_attribute *battr, umode_t mode, size_t size,
-		kuid_t uid, kgid_t gid, const struct ns_common *ns);
 
 /*
  * symlink.c
diff --git a/include/linux/device.h b/include/linux/device.h
index 39e08e8c950c6..e5485bfbc6c84 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -88,6 +88,62 @@ int subsys_system_register(const struct bus_type *subsys,
 int subsys_virtual_register(const struct bus_type *subsys,
 			    const struct attribute_group **groups);
 
+/**
+ * enum dev_sysfs_action - verb selector for device_sysfs_apply()
+ * @DEV_SYSFS_ADD_ONE: realize a single named entry (lazy populate_one
+ *		       miss path); walker stops at the first row whose
+ *		       @applies_to passes and whose create() returns
+ *		       anything other than -ENOENT.
+ * @DEV_SYSFS_ADD_ALL: realize every applicable entry (eager device_add
+ *		       or lazy populate_all); best-effort, per-row errors
+ *		       do not abort the walk.
+ * @DEV_SYSFS_REMOVE_ALL: tear down every applicable entry in reverse
+ *		       row order (device_del teardown).
+ */
+enum dev_sysfs_action {
+	DEV_SYSFS_ADD_ONE,
+	DEV_SYSFS_ADD_ALL,
+	DEV_SYSFS_REMOVE_ALL,
+};
+
+/**
+ * struct device_sysfs_entry - declarative per-device sysfs content row
+ * @name:	Attribute or symlink name at the top level of the device's
+ *		sysfs directory, or %NULL for a wildcard row whose
+ *		create() performs internal name dispatch (typically a
+ *		group-source row iterating an attribute_group array).
+ * @applies_to: Optional predicate gating row eligibility for this
+ *		device. Must be cheap, non-sleeping, side-effect-free, and
+ *		monotonic for a given device state. MUST NOT acquire any
+ *		lock the walker's caller may already hold (notably
+ *		device_lock()). %NULL means unconditional.
+ * @create:	Required. Creates the row's sysfs content. For a named
+ *		row (@name != NULL) the @name argument equals @e->name on
+ *		ADD_ONE and %NULL on ADD_ALL. For a wildcard row the @name
+ *		argument is the ADD_ONE target (or %NULL on ADD_ALL) and
+ *		the row's create() matches internally, returning -ENOENT
+ *		to signal "not my name" so the walker continues. Must
+ *		convert -EEXIST from concurrent racers to 0.
+ * @remove:	Optional reverse-of-realize teardown. Called on
+ *		REMOVE_ALL in reverse row order. MUST NOT fail the walk.
+ *
+ * Rows are declared in file-static, sentinel-terminated tables whose
+ * base pointer is published to the walker via struct kobj_type.entries
+ * (device ktype shares a single driver_core table and dispatches to
+ * dev->type->entries as well). The row shape mirrors cftype +
+ * cgroup_addrm_files (kernel/cgroup/cgroup.c) and the
+ * pci_sysfs_entries[] at drivers/pci/pci-sysfs.c (added later in
+ * the series); see Documentation/driver-api/sysfs-lazy.rst (also
+ * added later in the series) for the full walker contract and
+ * error-handling matrix.
+ */
+struct device_sysfs_entry {
+	const char *name;
+	bool (*applies_to)(struct device *dev);
+	int  (*create)(struct device *dev, const char *name);
+	void (*remove)(struct device *dev);
+};
+
 /*
  * The type of device, "struct device" is embedded in. A class
  * or bus can contain devices of different types
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index cec6de1720076..c724d86e1a049 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -61,6 +61,8 @@ enum kobject_action {
 	KOBJ_UNBIND,
 };
 
+struct device_sysfs_entry;
+
 struct kobject {
 	const char		*name;
 	struct list_head	entry;
@@ -130,6 +132,9 @@ struct kobj_type {
 	 */
 	int (*populate)(struct kobject *kobj, const char *name);
 	void (*populate_all)(struct kobject *kobj);
+
+	/* Optional table of per-attribute entries (see device_sysfs_apply()). */
+	const struct device_sysfs_entry *entries;
 };
 
 struct kobj_uevent_env {
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index de211563f3dec..aac2f773d5378 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -415,6 +415,12 @@ int __must_check sysfs_create_files(struct kobject *kobj,
 				   const struct attribute * const *attr);
 int __must_check sysfs_chmod_file(struct kobject *kobj,
 				  const struct attribute *attr, umode_t mode);
+int __must_check sysfs_add_file_mode_ns(struct kernfs_node *parent,
+		const struct attribute *attr, umode_t amode, kuid_t uid,
+		kgid_t gid, const struct ns_common *ns);
+int __must_check sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
+		const struct bin_attribute *battr, umode_t mode, size_t size,
+		kuid_t uid, kgid_t gid, const struct ns_common *ns);
 struct kernfs_node *sysfs_break_active_protection(struct kobject *kobj,
 						  const struct attribute *attr);
 void sysfs_unbreak_active_protection(struct kernfs_node *kn);
@@ -558,6 +564,24 @@ static inline int sysfs_chmod_file(struct kobject *kobj,
 	return 0;
 }
 
+static inline int sysfs_add_file_mode_ns(struct kernfs_node *parent,
+					 const struct attribute *attr,
+					 umode_t amode, kuid_t uid,
+					 kgid_t gid,
+					 const struct ns_common *ns)
+{
+	return 0;
+}
+
+static inline int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
+					     const struct bin_attribute *battr,
+					     umode_t mode, size_t size,
+					     kuid_t uid, kgid_t gid,
+					     const struct ns_common *ns)
+{
+	return 0;
+}
+
 static inline struct kernfs_node *
 sysfs_break_active_protection(struct kobject *kobj,
 			      const struct attribute *attr)
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



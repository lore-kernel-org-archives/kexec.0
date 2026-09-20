Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60BEC982D8
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=748fu/RuSuWEHxLL4+C7te7l41PPhxbrrdqn5kAp7do=; b=CnTJrIwvs61pstBPnSjOxLPoaN
	lmJ2Wr4BoAQJPrwMQ4FvpXAKhP8/SDlu6P23F/40fofDd1/qPs0GSRDv+C+Z3++Sr1WqNPlWM3dwt
	Ny0B3Tzr9kK84V7aBn81ohp6S3hNNR0m7WmPjkYyz8iuHtW9GiM142foXVZ+ANV7aJD03KrHVM4JK
	N0rJd3YivwR62y++PhkYqRkBlHRd37VwPjzXemyMfjOrgDKGIkf83pKOmiabwO7KR6Z3oR+4ZF1J+
	3v6Cq44Cxw8q6je47IRsxWeb5+f5KECoNc22dL6ZSGDgzHzpheeoQDXT1O4eqDYk/aiXsVJC/GZbe
	f2qqGBPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4s-00000000NZm-1Ecd;
	Sun, 20 Sep 2026 20:23:58 +0000
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NN4-00000000IsU-3lgi
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:38:44 +0000
Received: by mail-yx2-x10.google.com with SMTP id 00721157ae682-85d43ac608dso16455427b3.3
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933122; x=1790537922; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=748fu/RuSuWEHxLL4+C7te7l41PPhxbrrdqn5kAp7do=;
        b=axQsB8AEKwGzeAzmoI1TCTKcdjcKhc3DLhcVgzCj/cgb6vW/UC5A6T1YFqKRbIFwa1
         Gl7r2uJFYSVn2tbwNr2crxT0LJ2La+k98OdL1rTkuwh6zUqdd2wMRcK0n100shIO3N0b
         vltfogh/GQ9l6ulwbmJCDcTWbnA5rawZNICkO6xJb3BnmVVnDJTfTzvGWifnNxIdWyiL
         uQsEMAJpe6v4bIXTzdS58MLknmpsS0iClFvWub+Dmio2EN5IaXAiMj+Gv2aBbWaPkYJA
         2Ziu8WQ994jmPgpSp4TZpdEm46xis47i6h4NyDyz0wg2B9Kqno0PCyER4Ya5m0xxesNZ
         SzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933122; x=1790537922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=748fu/RuSuWEHxLL4+C7te7l41PPhxbrrdqn5kAp7do=;
        b=IBVmZzgSVaZgfXqIZQ7fN5eP5Uh8JQM4SeR+PWXcUyaRKZ1FuZIY6ZtyeRVkF8WfgW
         1brHqePGQTfa6Jhi13BN+q8uLmtH3+mtGZv9c1hw8K5OLmV97FDHG9umpv66OQ2456+j
         fX44Io2tl0aumtqoXxO/aZpug2Mt4tpMgVhPE98Y7Dzx28KFTl6Lg/OR/wR1nFxqMSN0
         LIgo5zmFyZ9EUSrPjQbf3YIIEvLSwJegp/8fubaaZ+p+W5/Zf4cT5+EtuH2zfsuAfJAT
         AZiFQnLjVJy8ZxfT/at1NQ15UFtto9I2guzFV5+mPIfc+3V03ez+96aN2pd4EdpOuVYk
         RtLw==
X-Forwarded-Encrypted: i=1; AKwUvBynCBUa8oP2IGEm1MHL7atfzRqrmzpF5HZN3ifaNTfoAFvMoTvaaDVWC9pRBAST1Qfc+tzo7g==@lists.infradead.org
X-Gm-Message-State: AFuF++kMPa1Q4eomMUe2RsK0Mf09o1lJnt09pDD2oyoOX64FKOFu2Iiz
	SzdZFrBUix7ay4eQ24iOMiG3t9RcDy2rDltpCVr9WkR+bkqbxtUURwPLTN+8I1yN3Po=
X-Gm-Gg: AYBFou3YvGG3Ke6E9ZDqfWrDHPdrwE1nKnB/TiRTlaSDLQuQpnvDhBPJUUK946CUiqn
	oQvOZthHAYrZl4CeaLPONAck24/0QTiEToHwtbEhhgdLweWZn14Z34KdMBrqsRPpNoZNVwjk/S/
	jU76FcL/xuNNPl/UWS2FXEoCBqxKvNUoTVL9oUCOlec8H9EtU96FkIoPMw35V2aVK2Jbp05yipR
	gCkXsXIPHxb6KegHz1Zz+Ioan4M0Qw7ksvO2vW8AdZkoMucZ6h3ut5Kw507xWPFgHsVxTMsbgTb
	KotyC18o8kmNFmK8aL95eJR7wCsYUHpYjkmSykj0cby5/54HibWxvJk1kKFfJqjfkcAbRtO7Amf
	vCWDd8IFG/ZPwZnwVPJn+1VB3trNjvIIcmDVEeZF8A1XSFv6CmOVj5bvQ/FiMh/A7LO67v+UJhG
	Uy+cIuLZS4AMfH4qK00GCV5WEk6/hNEqnPBE7wnJnsaXSpFkOUGlNASsqI3Lq9/cudEqB/tj34O
	TGUI/+7hE8hJ6upTc2+gdgn86ji8n2trq70pjNgEGkYOvI65tdQf/WyfUycfV+tcHQxetghgbc/
	zI8JgsWYNDUC7BvdGhN6XR8wHE24dzk=
X-Received: by 2002:a05:690c:6a0d:b0:857:f33:6f1d with SMTP id 00721157ae682-897311d51a6mr25294217b3.6.1789933121962;
        Sun, 20 Sep 2026 12:38:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a41521d6csm18803647b3.1.2026.09.20.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:38:41 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 18/46] liveupdate: cpu_preserve: Add LUO file handler for preserved physical CPUs
Date: Sun, 20 Sep 2026 15:36:22 -0400
Message-ID: <20260920193650.3373435-19-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123842_958420_0558FF5B 
X-CRM114-Status: GOOD (  15.29  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:19 -0700
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

Implement the LUO file handler (cpu_preserve_handler) and early boot
incoming CPU adoption for /sys/devices/system/cpu/cpuX/preserve fds.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/cpu_preserve.c | 189 ++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/cpu_preserve.c b/kernel/liveupdate/cpu_preserve.c
index 2f92dfee82b1..9a039ba9e912 100644
--- a/kernel/liveupdate/cpu_preserve.c
+++ b/kernel/liveupdate/cpu_preserve.c
@@ -837,8 +837,10 @@ void __cpu_preserved_text cpu_preserved_set_dead(int cpu)
 {
 	struct cpu_preserved_pcpu_ser *ser = cpu_preserved_get_pcpu_ser(cpu);
 
-	if (ser)
-		WRITE_ONCE(ser->workload, CPU_PRESERVED_DEAD);
+	if (ser) {
+		smp_store_release(&ser->workload, CPU_PRESERVED_DEAD);
+		cpu_preserved_clean(ser);
+	}
 }
 EXPORT_SYMBOL_GPL(cpu_preserved_set_dead);
 
@@ -1097,8 +1099,6 @@ void __cpu_preserved_text cpu_preserved_park_loop(int cpu)
 		switch (READ_ONCE(ser->workload)) {
 		case CPU_PRESERVED_EXITING:
 		case CPU_PRESERVED_DEAD:
-			WRITE_ONCE(ser->workload, CPU_PRESERVED_DEAD);
-			cpu_preserved_clean(ser);
 			return;
 		case CPU_PRESERVED_WORKLOAD:
 			cpu_preserved_run_workload(ser, pcpu);
@@ -1131,6 +1131,7 @@ void cpu_preserved_park(int cpu)
 	} else {
 		cpu_preserved_park_loop(cpu);
 		arch_cpu_preserved_park_finish(cpu);
+		cpu_preserved_set_dead(cpu);
 	}
 }
 EXPORT_SYMBOL_GPL(cpu_preserved_park);
@@ -1498,6 +1499,171 @@ static struct liveupdate_flb cpu_preserved_flb = {
 	.compatible = CPU_PRESERVED_LUO_FLB_COMPATIBLE,
 };
 
+/*
+ * LUO File Handler Callbacks for /sys/devices/system/cpu/cpu<N>/preserve
+ */
+static int file_to_cpu(struct file *file, unsigned int *cpup)
+{
+	struct dentry *dentry, *parent;
+	unsigned int cpu;
+
+	if (!file || !file->f_path.dentry)
+		return -EINVAL;
+
+	if (file_inode(file)->i_sb->s_magic != SYSFS_MAGIC)
+		return -EINVAL;
+
+	dentry = file->f_path.dentry;
+	if (strcmp(dentry->d_name.name, "preserve"))
+		return -EINVAL;
+
+	parent = dentry->d_parent;
+	if (!parent || sscanf(parent->d_name.name, "cpu%u", &cpu) != 1)
+		return -EINVAL;
+
+	if (cpu >= nr_cpu_ids || !cpu_possible(cpu) ||
+	    !cpu_is_hotpluggable(cpu)) {
+		return -EINVAL;
+	}
+
+	*cpup = cpu;
+	return 0;
+}
+
+static bool cpu_preserve_can_preserve(struct liveupdate_file_handler *handler,
+				      struct file *file)
+{
+	unsigned int cpu;
+
+	return IS_ENABLED(CONFIG_LIVEUPDATE_ONCORE) && file_to_cpu(file, &cpu) == 0;
+}
+
+static int cpu_preserve_preserve(struct liveupdate_file_op_args *args)
+{
+	struct cpu_preserved_file_ser *fser;
+	unsigned int cpu;
+	int ret;
+
+	ret = file_to_cpu(args->file, &cpu);
+	if (ret)
+		return ret;
+
+	ret = cpu_preserve(cpu);
+	if (ret)
+		return ret;
+
+	fser = kho_alloc_preserve(sizeof(*fser));
+	if (IS_ERR(fser)) {
+		cpu_unpreserve(cpu);
+		return PTR_ERR(fser);
+	}
+
+	memset(fser, 0, sizeof(*fser));
+	fser->cpu = cpu;
+
+	scoped_guard(mutex, &cpu_preserved_lock)
+		fser->stack_pa = cpu_preserved_outgoing.pcpus[cpu].stack_pa;
+
+	args->serialized_data = virt_to_phys(fser);
+	return 0;
+}
+
+static void cpu_preserve_unpreserve(struct liveupdate_file_op_args *args)
+{
+	struct cpu_preserved_file_ser *fser;
+	unsigned int cpu;
+
+	if (!args->serialized_data)
+		return;
+
+	fser = phys_to_virt(args->serialized_data);
+	cpu = fser->cpu;
+
+	cpu_unpreserve(cpu);
+
+	kho_unpreserve_free(fser);
+}
+
+static void cpu_preserve_restore_incoming_cpu(struct liveupdate_session *session,
+					      struct cpu_preserved_file_ser *fser)
+{
+	unsigned int cpu = fser->cpu;
+
+	scoped_guard(mutex, &cpu_preserved_lock) {
+		cpumask_set_cpu(cpu, &cpu_preserved_incoming.mask);
+		cpumask_set_cpu(cpu, &cpu_preserved_mask);
+
+		if (!cpu_preserved_incoming.pcpus) {
+			cpu_preserved_incoming.pcpus =
+				kcalloc(nr_cpu_ids,
+					sizeof(*cpu_preserved_incoming.pcpus),
+					GFP_KERNEL);
+			WRITE_ONCE(cpu_preserved_host_pcpus_va,
+				   cpu_preserved_incoming.pcpus);
+			cpu_preserved_clean(&cpu_preserved_host_pcpus_va);
+		}
+
+		if (cpu_preserved_incoming.pcpus)
+			cpu_preserved_incoming.pcpus[cpu].stack_pa = fser->stack_pa;
+
+		cpu_preserved_clean(&cpu_preserved_mask);
+	}
+}
+
+static int cpu_preserve_retrieve(struct liveupdate_file_op_args *args)
+{
+	struct cpu_preserved_file_ser *fser;
+	struct file *file;
+	char path[64];
+
+	if (!args->serialized_data)
+		return -EINVAL;
+
+	fser = phys_to_virt(args->serialized_data);
+
+	snprintf(path, sizeof(path),
+		 "/sys/devices/system/cpu/cpu%u/preserve", fser->cpu);
+	file = filp_open(path, O_RDONLY, 0);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	args->file = file;
+	cpu_preserve_restore_incoming_cpu(args->session, fser);
+	cpu_preserved_detach_workload(fser->cpu);
+
+	return 0;
+}
+
+static void cpu_preserve_finish(struct liveupdate_file_op_args *args)
+{
+	struct cpu_preserved_file_ser *fser;
+
+	if (!args->serialized_data)
+		return;
+
+	fser = phys_to_virt(args->serialized_data);
+	if (args->retrieve_status <= 0)
+		cpu_preserve_restore_incoming_cpu(args->session, fser);
+
+	cpu_unpreserve(fser->cpu);
+
+	kho_restore_free(fser);
+}
+
+static const struct liveupdate_file_ops cpu_preserve_file_ops = {
+	.can_preserve = cpu_preserve_can_preserve,
+	.preserve     = cpu_preserve_preserve,
+	.retrieve     = cpu_preserve_retrieve,
+	.unpreserve   = cpu_preserve_unpreserve,
+	.finish       = cpu_preserve_finish,
+	.owner        = THIS_MODULE,
+};
+
+static struct liveupdate_file_handler cpu_preserve_handler = {
+	.ops        = &cpu_preserve_file_ops,
+	.compatible = CPU_PRESERVED_LUO_FH_COMPATIBLE,
+};
+
 static int cpu_preserve_reboot_notify(struct notifier_block *nb,
 				      unsigned long action, void *data)
 {
@@ -1555,6 +1721,21 @@ static int __init cpu_preserve_early_init(void)
 	cpu_preserved_incoming.pcpus_ser = NULL;
 	cpu_preserved_global_ser = NULL;
 
+	err = liveupdate_register_file_handler(&cpu_preserve_handler);
+	if (err && err != -EOPNOTSUPP) {
+		pr_err("Could not register cpu_preserve file handler: %pe\n",
+		       ERR_PTR(err));
+		return err;
+	}
+
+	err = liveupdate_register_flb(&cpu_preserve_handler,
+				      &cpu_preserved_flb);
+	if (err && err != -EOPNOTSUPP) {
+		pr_err("Could not register cpu_preserved FLB: %pe\n",
+		       ERR_PTR(err));
+		return err;
+	}
+
 	/* Retrieve incoming preserved CPUs before secondary CPU bringup */
 	if (liveupdate_enabled())
 		liveupdate_flb_get_incoming(&cpu_preserved_flb, &obj);
-- 
2.55.0.1082.g2b9226bbc0-goog



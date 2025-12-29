Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC411E92FE0
	for <kexec@archiver.kernel.org>; Mon, 29 Dec 2025 21:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hzQxvCy96Xx16IuJDlzp/I3CvO+EN61+BaDrkAXVybM=; b=ZWG3WPIt7yG6FUdMWRKt6dX+G9
	MBw8ouauwtVaQ9LMAr7Je4Az8z3vr3fLt0nlHHO4TvWauWQXSJeQV3V9uembxNHgq9IbiJT+VDorU
	Mw3YxVrg9ievXx2aRoul1tXzmSR3HMAF9CRv3Vryhkek6AHFk+OWKTVgCS/pgugGIsHJtm+215Wb1
	tGP+HJyT7oMaYYQYfnHmMgZoqGH1WPwp4KQmLYxeUwbg22wBlsyFKekwofuoW1bcgmeZRVoTAfEIG
	EdDy8lZL18415z1CSIufmxwTJBxYokV4xv0i+K5vaxo6ByVCtvHF94V5YoQtbeeZKGNKCW/XBwbiE
	KRhva/nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKhx-000000044y7-1TFN;
	Mon, 29 Dec 2025 21:23:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKhw-000000044xz-3Cbv
	for kexec@lists.infradead.org;
	Mon, 29 Dec 2025 21:23:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 34E4B6000A;
	Mon, 29 Dec 2025 21:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315C8C4CEF7;
	Mon, 29 Dec 2025 21:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767043395;
	bh=ppbBQjEpvh2+LXrZY1d3Kq7C72kmO3Q+fdDz1wTrWH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=K+BO6T7ZA/dB4XxZl8TWSFjrd2UrZeO0W5RIQspSlmSzzh6put6N1vexWIWXKnrzb
	 TADtYVxjYVpDETlpAa/4Z9qSvx45Z7eK1UclXHAaFZ4E2gVXKe6iVSO6GiqFsNw2Eh
	 e9Z/5uGzlliUj1KPcZo6QdZUxbuMD+VcHzznm9inCudN6vmWgET38bLfNiHcB4wVHZ
	 YaJiDhm4bmhAOPoTjXuTI5/HEBM9gt6T79Prj8wr7yjs+wvz9mkMeNPzex5F+EBE2n
	 +u5UPnzxdaCSD8lmraoutlNAXbOYdj0ObEFYt9Ut5Vm8hre+1ubmR/qJvCsdixVI8w
	 UCrU015z6iuOw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@kernel.org>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  "Liam
 R. Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,
  Jonathan Corbet <corbet@lwn.net>,  Thomas Gleixner <tglx@linutronix.de>,
  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>,  Dave
 Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,  "H. Peter Anvin"
 <hpa@zytor.com>,  Muchun Song <muchun.song@linux.dev>,  Oscar Salvador
 <osalvador@suse.de>,  Alexander Graf <graf@amazon.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason
 Gunthorpe <jgg@nvidia.com>,  Samiullah Khawaja <skhawaja@google.com>,
  Vipin Sharma <vipinsh@google.com>,  Zhu Yanjun <yanjun.zhu@linux.dev>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org,  kexec@lists.infradead.org
Subject: Re: [RFC PATCH 03/10] liveupdate: do early initialization before
 hugepages are allocated
In-Reply-To: <CA+CK2bApV4A-hCO3eHX7-1QdjDX=FpnrVHfa8TQBt_1JStY-BA@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 23 Dec 2025 13:08:59 -0500")
References: <20251206230222.853493-1-pratyush@kernel.org>
	<20251206230222.853493-4-pratyush@kernel.org>
	<CA+CK2bApV4A-hCO3eHX7-1QdjDX=FpnrVHfa8TQBt_1JStY-BA@mail.gmail.com>
Date: Mon, 29 Dec 2025 22:23:06 +0100
Message-ID: <86ms317zk5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, Dec 23 2025, Pasha Tatashin wrote:

> On Sat, Dec 6, 2025 at 6:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> To support hugepage preservation using LUO, the hugetlb subsystem needs
>> to get liveupdate data when it allocates the hugepages to find out how
>> many pages are coming from live update.
>>
>> Move early LUO init from early_initcall to mm_core_init(). This is where
>> gigantic hugepages are allocated on ARM64. On x86, they are allocated in
>> setup_arch(), so have a call there as well. Keep track of whether the
>> function was already called to avoid double-init.
>>
>> liveupdate_early_init() only gets the KHO subtree and validates the data
>> to ensure it is valid and understood. These are read-only operations and
>> do not need much from the system, so it is safe to call early in boot.
>>
>> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
>> ---
>>  arch/x86/kernel/setup.c          |  7 +++++++
>>  include/linux/liveupdate.h       |  6 ++++++
>>  kernel/liveupdate/luo_core.c     | 30 ++++++++++++++++++++++++++----
>>  kernel/liveupdate/luo_internal.h |  2 ++
>>  mm/mm_init.c                     |  7 +++++++
>>  5 files changed, 48 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 9bf00287c408..e2ec779afc2c 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/tboot.h>
>>  #include <linux/usb/xhci-dbgp.h>
>>  #include <linux/vmalloc.h>
>> +#include <linux/liveupdate.h>
>>
>>  #include <uapi/linux/mount.h>
>>
>> @@ -1216,6 +1217,12 @@ void __init setup_arch(char **cmdline_p)
>>
>>         kho_memory_init();
>>
>> +       /*
>> +        * Hugepages might be preserved from a liveupdate. Make sure it =
is
>> +        * initialized so hugetlb can query its state.
>> +        */
>> +       liveupdate_early_init();
>> +
>>         if (boot_cpu_has(X86_FEATURE_GBPAGES)) {
>>                 hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>>                 hugetlb_bootmem_alloc();
>> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
>> index ed81e7b31a9f..78e8c529e4e7 100644
>> --- a/include/linux/liveupdate.h
>> +++ b/include/linux/liveupdate.h
>> @@ -214,6 +214,8 @@ struct liveupdate_flb {
>>
>>  #ifdef CONFIG_LIVEUPDATE
>>
>> +void __init liveupdate_early_init(void);
>> +
>>  /* Return true if live update orchestrator is enabled */
>>  bool liveupdate_enabled(void);
>>
>> @@ -233,6 +235,10 @@ int liveupdate_flb_get_outgoing(struct liveupdate_f=
lb *flb, void **objp);
>>
>>  #else /* CONFIG_LIVEUPDATE */
>>
>> +static inline void liveupdate_early_init(void)
>> +{
>> +}
>> +
>>  static inline bool liveupdate_enabled(void)
>>  {
>>         return false;
>> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
>> index 7a9ef16b37d8..2c740ecad8e6 100644
>> --- a/kernel/liveupdate/luo_core.c
>> +++ b/kernel/liveupdate/luo_core.c
>> @@ -69,6 +69,13 @@ static struct {
>>         u64 liveupdate_num;
>>  } luo_global;
>>
>> +static bool __luo_early_initialized __initdata;
>> +
>> +bool __init luo_early_initialized(void)
>> +{
>> +       return __luo_early_initialized;
>> +}
>
> I think the above is not needed, both the global variable, and a new func=
tion.

The function is used by liveupdate_flb_incoming_early() for
sanity-checking. Since we are getting rid of that, I can drop the
function too.

>
>> +
>>  static int __init early_liveupdate_param(char *buf)
>>  {
>>         return kstrtobool(buf, &luo_global.enabled);
>> @@ -133,20 +140,35 @@ static int __init luo_early_startup(void)
>>         return err;
>>  }
>>
>> -static int __init liveupdate_early_init(void)
>> +/*
>> + * This should only be called after KHO FDT is known. It gets the LUO s=
ubtree
>> + * and does initial validation, making early boot read-only access poss=
ible.
>> + */
>> +void __init liveupdate_early_init(void)
>>  {
>>         int err;
>>
>> +       /*
>> +        * HugeTLB needs LUO to be initialized early in boot, before gig=
antic
>> +        * hugepages are allocated. On x86, that happens in setup_arch()=
, but on
>> +        * ARM64 (and other architectures) that happens in mm_core_init(=
).
>> +        *
>> +        * Since the code in mm_core_init() is shared between all archit=
ectures,
>> +        * this can lead to the init being called twice. Skip if initial=
ization
>> +        * was already done.
>> +        */
>> +       if (__luo_early_initialized)
>> +               return;
>> +
>> +       __luo_early_initialized =3D true;
>
> Please, make __luo_early_initialized static local.

Sure, will do.

>
>> +
>>         err =3D luo_early_startup();
>>         if (err) {
>>                 luo_global.enabled =3D false;
>>                 luo_restore_fail("The incoming tree failed to initialize=
 properly [%pe], disabling live update\n",
>>                                  ERR_PTR(err));
>>         }
>> -
>> -       return err;
>>  }
>> -early_initcall(liveupdate_early_init);
>>
>>  /* Called during boot to create outgoing LUO fdt tree */
>>  static int __init luo_fdt_setup(void)
>> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_in=
ternal.h
>> index 6115d6a4054d..171c54af7b38 100644
>> --- a/kernel/liveupdate/luo_internal.h
>> +++ b/kernel/liveupdate/luo_internal.h
>> @@ -114,6 +114,8 @@ int __init luo_flb_setup_outgoing(void *fdt);
>>  int __init luo_flb_setup_incoming(void *fdt);
>>  void luo_flb_serialize(void);
>>
>> +bool __init luo_early_initialized(void);
>> +
>>  #ifdef CONFIG_LIVEUPDATE_TEST
>>  void liveupdate_test_register(struct liveupdate_file_handler *fh);
>>  void liveupdate_test_unregister(struct liveupdate_file_handler *fh);
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 93cec06c1c8a..9a5b06a93622 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/execmem.h>
>>  #include <linux/vmstat.h>
>>  #include <linux/kexec_handover.h>
>> +#include <linux/liveupdate.h>
>>  #include <linux/hugetlb.h>
>>  #include "internal.h"
>>  #include "slab.h"
>> @@ -2681,6 +2682,12 @@ void __init mm_core_init(void)
>>         arch_mm_preinit();
>>
>>         kho_memory_init();
>> +       /*
>> +        * Hugepages might be preserved from a liveupdate. Make sure it =
is
>> +        * initialized so hugetlb can query its state.
>> +        */
>> +       liveupdate_early_init();
>> +
>>         hugetlb_bootmem_alloc();
>>
>>         /* Initializations relying on SMP setup */
>> --
>> 2.43.0
>>

--=20
Regards,
Pratyush Yadav


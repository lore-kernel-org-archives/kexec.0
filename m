Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2F5C6FD1F
	for <kexec@archiver.kernel.org>; Sat, 25 Mar 2023 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P9jtlvWz8tO0k86MP7PgLkJ9n/VYnht7MYRbVVkHPGs=; b=EtySJCjBFDbYG3
	Dtk0u/KsfXkLKIGHtQShUECc3FTSfARNjGuVSNhqhPWuvlaJNmuaHhaunHHC2BVT3Rq7S3aYumLJ9
	SyG8Io7mNNRWZQJfz3uR9vYAYRZownxaUv2KG5Cb06js6t1tRGWnw1EFdBnqFxyjoinVtGV5Md6dY
	Tdh8WAcRaXn+HvHYz4biVrxJZcrum76Ly6/bup4+fXuwCd9NlHQ12M7gQ2Zpvf5bRJpktVNvPAn1v
	a1V1JgDEoOECgcARHGPmHyynXaxDW+wyAH23/btzsmxCsUnLNR8llXaOTm8djG9kO0oSLaSKXl/OR
	yFF5ltM1ZjQBOnECR2og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pg6i9-006zCp-1q;
	Sat, 25 Mar 2023 16:25:45 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pg6i5-006zBm-25
	for kexec@lists.infradead.org;
	Sat, 25 Mar 2023 16:25:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679761541; x=1711297541;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jwQo2o3j71BDLtr4OFKx+Otx015kQ5o0XvirVcMommY=;
  b=YoT5E7nXT6TlNwiQM6n4lMC7GTUQONYy6cQpK/Ucs2F1kB4mMBkt9iTf
   ro8C7LGLDgtc5g/X8YRgIFeA7Jbc0qsZHgpkTTO9VhXHKRbGoJUKL8tyI
   6VuakgzwVGBzU1f2wDomlJgZzrZDYhOqKn5GyGbfjiSCyWJuwz3NBS63S
   paNFeo5eRMblmiBFuTK/jj2tcFKOram1N4f4U2t83hmtXdbvs/YVy27tR
   +Db1nn+sS/HG4tGjiohS/bIqhx6Ei2eQugZzAPyJaj6ewAyeOkTBeQmoi
   mRaDxLWUVVyRNFmchwdZv49bvsnloLI9P0AZUHayINOqXLk5osOEAG3hA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="367725481"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="367725481"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="660402602"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="660402602"
Received: from jsgross-mobl2.amr.corp.intel.com (HELO [10.209.122.137]) ([10.209.122.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:25:37 -0700
Message-ID: <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
Date: Sat, 25 Mar 2023 09:25:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] x86: Disable kexec for TDX guests
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230325_092541_720875_F01AB30B 
X-CRM114-Status: GOOD (  14.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 3/25/23 09:01, Kirill A. Shutemov wrote:
> The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
> secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
> it has woken up.
...
> +int arch_kexec_load(void)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> +		pr_warn_once("Disable kexec: not yet supported in TDX guest\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}

So, let's put all this together:

1. TDX implementations use MADT for wakeup exclusively right now (but
   are not necessarily _required_ to do so forever)
2. MADT doesn't support CPU offlining
3. kexec() requires offlining

Thus, current TDX implementations can't support TDX guests.  This
*doesn't* say that TDX will always use the MADT for wakeups.

Yet, the check you have here is for TDX and *not* for the MADT.

That seems wrong.

Let's say SEV or arm64 comes along and uses the MADT for their guests.
They'll add another arch_kexec_load(), with a check for *their* feature.

This all seems like you should be disabling kexec() the moment the MADT
CPU wakeup is used instead of making it based on TDX.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

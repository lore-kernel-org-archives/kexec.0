Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C20EEAA4E
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:
	Cc:To:Subject:MIME-Version:Date:Message-ID:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VazNXpI1/P94IIAQtiHmM3xJkU+FkfwR+Q21obVo84Q=; b=qkB+t6KasKLQRHGt+r00yZCoDq
	xE5vBgtuD53KcNtwRl4KPFW9G0VPgavQ+5i9C4HU3gj0wcx7qEvcSs2TovWBn3ieFwBl4xwCrEHhJ
	1cqF+wqTZyKixiiH90an+mq4mO7ewUcJo1CTVEnDx92ve3IFCRwhiwCYnPbSc94HY9mgGO8cQnYhr
	WWyqpMsxKOiZwbjfIPEZzzmAq2YWfE0eN3lcZyQNsaZmQKYVrGWduUhCiFa0ZhmSwyaQ/7VdEV3xi
	aRzMFK3SZS5tubyeQIlNVC0SJAcyZ/yf276SyHxevrcOIi+pW8R/uMGhPS3xBgIfELC8yhq6/VJnd
	zxxtFJbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgodN-008psY-2u;
	Thu, 14 Sep 2023 15:52:01 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgodK-008pqG-1P
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 15:52:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694706718; x=1726242718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=osGMSR+/Sl/IIMT4WBHGk2JmyeEImW8mWC+HknDgaww=;
  b=WfBnXkawvi9eacdSVnzQGHhulG8SG0XNasLh54fY3u/62OB92o2raF+r
   GBoXOS3KYZcFFAwEuj+I4IiAeAKJWBknPdZs7iJStZeiNRagE0dY9q5NO
   IxxwC7ma54C6bVgY9jaUcIms3Kq5toFjYh264wRNhJHGThq0RkchDJY6L
   ASqlbFN83s44phZElbfQoYEiwXnT/dbjChhWGiiQymgnBVm/cKCLnop0k
   ArdDWC3XwB6Q0sed2/KdVtm37IOaRE+GeT3IdtGv5T318e7r+ox6soNFT
   zY+2wEc7W+1z/6kGg180pYfFUlrdoYud9RDkiJKwdD8QhiLcUwypJSwXo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="364040314"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="364040314"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="694354783"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="694354783"
Received: from spswartz-mobl.amr.corp.intel.com (HELO [10.209.21.97]) ([10.209.21.97])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:51:51 -0700
Content-Type: multipart/mixed; boundary="------------s3GVNQ58hbmXD3GP00R55XLl"
Message-ID: <45cdb5ae-986e-d186-f0fd-a308f946ce8d@intel.com>
Date: Thu, 14 Sep 2023 08:51:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] x86/boot/compressed: Reserve more memory for page tables
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb@google.com>, Kees Cook <keescook@chromium.org>,
 Aaron Lu <aaron.lu@intel.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.de
References: <20230914123001.27659-1-kirill.shutemov@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230914123001.27659-1-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_085158_532258_BAB072BB 
X-CRM114-Status: GOOD (  16.12  )
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

This is a multi-part message in MIME format.
--------------s3GVNQ58hbmXD3GP00R55XLl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/23 05:30, Kirill A. Shutemov wrote:
> +/*
> + * Total number of page table kernel_add_identity_map() can allocate,
> + * including page tables consumed by startup_32().
> + */
> +# define BOOT_PGT_SIZE		(32*4096)

I agree that needing to know this in advance *exactly* is troublesome.

But I do think that we should preserve the comment about the worst-case
scenario.  Also, I thought this was triggered by unaccepted memory.  Am
I remembering it wrong?  How was it in play?

Either way, I think your general approach here is sound.  But let's add
one little tweak to at least warn when we're getting close to the limit.
 Now that nobody has to worry about the limit for the immediate future
it's a guarantee that in the long term someone will plow through it
accidentally.

Let's add a soft warning when we're nearing the limit so that there's a
chance to catch these things in the future.
--------------s3GVNQ58hbmXD3GP00R55XLl
Content-Type: text/x-patch; charset=UTF-8; name="pgtbuf.patch"
Content-Disposition: attachment; filename="pgtbuf.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9pZGVudF9tYXBfNjQuYyBi
L2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9pZGVudF9tYXBfNjQuYwppbmRleCBiY2M5NTZj
MTc4NzIuLjVkZmI2YTMxYmJiMSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvYm9vdC9jb21wcmVz
c2VkL2lkZW50X21hcF82NC5jCisrKyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9pZGVu
dF9tYXBfNjQuYwpAQCAtNTksNiArNTksMTMgQEAgc3RhdGljIHZvaWQgKmFsbG9jX3BndF9w
YWdlKHZvaWQgKmNvbnRleHQpCiAJCXJldHVybiBOVUxMOwogCX0KIAorCWlmIChwYWdlcy0+
cGd0X2J1Zl9vZmZzZXQgPj0gcGFnZXMtPnBndF9idWZfc2l6ZSAqIDMgLyA0KSB7CisJCWRl
YnVnX3B1dHN0cigicGd0X2J1ZiBydW5uaW5nIGxvdyBpbiAiIF9fRklMRV9fICJcbiIpOwor
CQlkZWJ1Z19wdXRzdHIoIk5lZWQgdG8gcmFpc2UgQk9PVF9QR1RfU0laRT8/XG4iKTsKKwkJ
ZGVidWdfcHV0YWRkcihwYWdlcy0+cGd0X2J1Zl9vZmZzZXQpOworCQlkZWJ1Z19wdXRhZGRy
KHBhZ2VzLT5wZ3RfYnVmX3NpemUpOworCX0KKwogCWVudHJ5ID0gcGFnZXMtPnBndF9idWYg
KyBwYWdlcy0+cGd0X2J1Zl9vZmZzZXQ7CiAJcGFnZXMtPnBndF9idWZfb2Zmc2V0ICs9IFBB
R0VfU0laRTsKIAo=

--------------s3GVNQ58hbmXD3GP00R55XLl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------s3GVNQ58hbmXD3GP00R55XLl--


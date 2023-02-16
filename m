Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E591BC636CC
	for <kexec@archiver.kernel.org>; Thu, 16 Feb 2023 18:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wn5GqFm3wSIrzxjcRyMmq4y1MO4X80rJWDImJ9BZn4Y=; b=lEZlwyRxyvt0Jj
	qJD0ZTLaHmC33Ca/f7UpDr04dXDfn+mfh3V2iZps21TnwPs2wRmWybXcv5lcYD8AKLOetxztWYlVx
	+DbOsgczSLn3WEbiVG3LY+47G/3BVX9TCL0Cb5twLcKC75CSdh2LJurXymmE6dyPxq/5hrETobH1m
	6mazGSBlgnfRiwPoN7qHZCnLqtNlhOVsNt6dxtMGwTNuNbrzhMeqTEPYI0eW+LfNOBRkfHWLm2U8j
	I6owsLC7ht2qUN+uRLjsmjLBPxh8DnlNrjaPI+riC4Pj10gzaLaRPpfg6pRRKUNLS495DUbs2L/fl
	Z0fbil5uQ45QDJOQ305A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSj43-00BXXX-Jw; Thu, 16 Feb 2023 18:33:03 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSj3y-00BXVq-AH
	for kexec@lists.infradead.org; Thu, 16 Feb 2023 18:33:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676572378; x=1708108378;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zfp7UkFHu3uObj2djITRWHGzW92NYU2r9XQ28CZ8TzM=;
  b=SwXCSo3nUZaa3lLUP6dslVrl+1rKK0bMtesO0/WcS48H1OKTpAHar7vc
   HNsEw8V9OyWuLqoKyxVwloo0MGz6fpWRSGprQLKHMq/LtCeBWrcOvGgBc
   gIzSlusioO/2BnHkZfYy91Ud78X4CRXs+NOZMPnEcEclzdWvioeL1pvjT
   HyHL4Kx4whxApPVpVJt2r3AOds91PF4FNmwAADjeeqYSvn3Eu4Z3sH/VM
   CLTM0Aa6QfJDOSNJF4IqMTb9s5ydrCrf/2GAIoC0l41a1VGPm+wWTRVaF
   4dxNLTO3FfQauNdHTjxNXRAJbP9oenxQJiYEhuziPGeyJgm/A2FIrrk79
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333998541"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333998541"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 10:32:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="670255337"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="670255337"
Received: from bjelliot-mobl1.amr.corp.intel.com (HELO [10.209.100.192]) ([10.209.100.192])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 10:32:47 -0800
Message-ID: <3ecc4208-9165-bc7c-d71b-2b93571f42af@intel.com>
Date: Thu, 16 Feb 2023 10:32:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <65fc95bb-5ad9-b589-d6a4-762289b3f6bc@intel.com>
 <20230216181230.3jn5hebv3xkdivbx@box.shutemov.name>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230216181230.3jn5hebv3xkdivbx@box.shutemov.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_103258_405266_C68C77B0 
X-CRM114-Status: GOOD (  11.20  )
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

On 2/16/23 10:12, Kirill A. Shutemov wrote:
> On Thu, Feb 16, 2023 at 09:50:32AM -0800, Dave Hansen wrote:
>> On 2/13/23 15:48, Kirill A. Shutemov wrote:
>>> The patch brings basic enabling of kexec in TDX guests.
>>>
>>> By "basic enabling" I mean, kexec in the guests with a single CPU.
>>> TDX guests use ACPI MADT MPWK to bring up secondary CPUs. The mechanism
>>> doesn't allow to put a CPU back offline if it has woken up.
>>>
>>> We are looking into this, but it might take time.
>> This is simple enough.  But, nobody will _actually_ use this code as-is,
>> right?  What's the point of applying it now?
> Why nobody? Single CPU VMs are not that uncommon.

Here's one data point: the only "General Purpose" ones I see AWS
offering are Haswell era:

	https://aws.amazon.com/ec2/instance-types/

That _might_ be because of concerns about SMT side-channel exposure on
anything newer.

So, we can argue about what "uncommon" means.  But, a minority of folks
care about 1-cpu VMs.  Also, a separate minority of folks care about
kexec().  I'm worried that the overlap between the two will be an
*OVERWHELMING* minority of folks.  In other words, so few people will
use this code that it'll just bitrot.

I'm looking for compelling arguments why mainline should carry this.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

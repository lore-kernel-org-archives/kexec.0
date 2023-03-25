Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F461C76196
	for <kexec@archiver.kernel.org>; Tue, 28 Mar 2023 05:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QVkzbv7pLzedSZKY4hqZKGO+W4BnqUngq1BgHdPGFcE=; b=XkhVWjrge+xgN5
	ojdSHn+gAAhUOLIQWoxWvM2NwtH67hgW5Ib98fP9meUZ4ps+Vq9OFqbkFsyCvinDlXiJM9n47rgjB
	PKtMbxsxHxrlmcoQkYUD9ZSVV8C4dAvl4tk/wkxEQ4kOeMHvIZYKAH8K5HEB5dP311vF5jpQZ/KCV
	Hwk67D2nUz0a7ZEUgXSCFek1+vymvQnHRQMYqRqogAsmWEXre+MOuEmDK3Aio/3E27t1eDycUHWu0
	sYBoeU/pLiuNvJE6NG+hwo8zfqyUqZby5FLlHiyh6ZGqV+8uMAXoILpqmspwgpOBmqPJ3gB4ByGmz
	7BiJQl27rH3yQ0JVbfbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph2H6-00DEKu-2A;
	Tue, 28 Mar 2023 05:53:40 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph2H4-00DEKM-2c
	for kexec@lists.infradead.org;
	Tue, 28 Mar 2023 05:53:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679982818; x=1711518818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FF+DUqCGHy8oPyFBqiYg8s10DunJo6T+TgdcwHN7O5g=;
  b=ESv2E2dNjMHASUtegF+EayvwPAK6RCh8Soc3l07IZvHlYJm5mDlJD45g
   DvpqBqTHk+wuAzcn5YthmLIxbIqcOjE4ItYnxcjP32hiZWrCFY07x0TJq
   1OeSdNkdN2lCcw3Ob8HbEVWCGmZA4+aZ7zwveGWDt78lmjgkXtl6LGtyX
   SdeXQt48wPG2DlHU71isKS2rDDTgMF5m2/ehPZth+KG1gyEkxGM9BIMmq
   BSkQ6I5p2N+axBu48UcN/hY5MmpK5mDRoWnWvKr+8n7UyLeMdhoIHiwJd
   ytU+dkGSedaTOaN9WgbEn8bq92R3psFqHZrFMwgGYE9cEIukaSCDvPza0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="403088284"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="403088284"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="752987372"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="752987372"
Received: from skunchit-mobl.amr.corp.intel.com (HELO [10.209.35.30]) ([10.209.35.30])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:53:36 -0700
Message-ID: <dfd8466a-9693-e469-31be-3d9158f19263@intel.com>
Date: Sat, 25 Mar 2023 09:20:47 -0700
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
X-CRM114-CacheID: sfid-20230327_225338_907859_456DB595 
X-CRM114-Status: UNSURE (   8.98  )
X-CRM114-Notice: Please train this message.
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

I'm not sure I like this approach.

TDX uses the MADT exclusively.

MADT-based systems can't offline CPUs.

kexec() requires

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

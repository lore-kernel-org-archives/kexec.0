Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA5AC77B73
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 11:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f8CLhu9xB0zmO9mjPWh6HM1KrY8wye/JrmhIkWMZBrY=; b=YUJbqv68MLXLdJ
	C6yYbvVqbdTjivS9GhS4ZHw9Zx/C2KQJlBk7dOOl7GmfCxEf1hxoWN86rqsD8BE+R3pxaeUdpxiXd
	GYh0Upw31CjLbqn5iQLj8Ukak4aysp52zl8Q074EEm/9jlXrnq+NbMX6t60dGXFLc0nz/+3Mw4HtG
	xlMN8kRO38vg9eFn9Q0bDualtjmVnjl3+hM2/2k5yVQsDNr3OWF2nXlpCN0b+AYEJIMWPad/wRgul
	1GvFYZxu7Zdfae7GPJ+/0XAVKun+yQVOUMicJxAD5LqGFLUbln4p/qYBmRXGwTB5a7R0QBN9X+2Gw
	42qrO7J+bXiuY4EAlbww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1przxr-006QsZ-1p;
	Thu, 27 Apr 2023 11:39:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1przxp-006Qro-1U
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 11:39:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B082063CA6;
	Thu, 27 Apr 2023 11:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983F9C433D2;
	Thu, 27 Apr 2023 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1682595544;
	bh=4rgucKIZ0mWJYXTLMoK/Iw2ESWS1PyrVYY7PH8TXaCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPOd/pfc++x0Pjtup6GWjQbCFu66wPW4KqFu8J/koiPblLLO0ZoZF/7QhgWpUcNKP
	 0jCMkQ01z7p3rCYIwH92lYVHEGR9KtJ6va6XsX9yBOMrvp58cuVTKoDcrrZ6uXytD4
	 b8CZ8lgyrbtKbRJk9EzzgqfflXNKxCCGCOXY3iB8=
Date: Thu, 27 Apr 2023 13:39:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: x86@kernel.org, nvdimm@lists.linux.dev, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, y-goto@fujitsu.com,
	yangx.jy@fujitsu.com, ruansy.fnst@fujitsu.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Takashi Iwai <tiwai@suse.de>, Baoquan He <bhe@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Colin Foster <colin.foster@in-advantage.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 3/3] resource, crash: Make kexec_file_load support
 pmem
Message-ID: <2023042726-railroad-detonator-cc0d@gregkh>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
 <20230427101838.12267-4-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230427101838.12267-4-lizhijian@fujitsu.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_043905_535740_140972D0 
X-CRM114-Status: GOOD (  10.94  )
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

On Thu, Apr 27, 2023 at 06:18:34PM +0800, Li Zhijian wrote:
> It does:
> 1. Add pmem region into PT_LOADs of vmcore
> 2. Mark pmem region's p_flags as PF_DEV

I'm sorry, but I can not parse this changelog.

Please take a look at the kernel documentation for how to write a good
changelog message so that we can properly review the change you wish to
have accepted.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.248])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K7phC-0005XH-MP
	for kexec@lists.infradead.org; Sun, 15 Jun 2008 10:42:51 +0000
Received: by rv-out-0708.google.com with SMTP id b17so6148784rvf.42
	for <kexec@lists.infradead.org>; Sun, 15 Jun 2008 03:42:49 -0700 (PDT)
Message-ID: <3877989d0806150342r5e5c6a0fy699dc4a8180d9b28@mail.gmail.com>
Date: Sun, 15 Jun 2008 18:42:49 +0800
From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: kdump regression: /proc/vmcore is 0 after kdump
In-Reply-To: <20080615115553.594e4ad7@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
References: <3877989d0806050058u3159e7b5x3113f63b3e0f3d8f@mail.gmail.com>
	<20080605081633.GA6713@verge.net.au>
	<3877989d0806130922p1f36a3bes9914144ac8c42266@mail.gmail.com>
	<3877989d0806150226x62fc1d1bk96131430f55848e1@mail.gmail.com>
	<20080615115553.594e4ad7@kopernikus.site>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-ia64@vger.kernel.org, Kexec Mailing List <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, andrew.patterson@hp.com, Roland McGrath <roland@redhat.com>

On Sun, Jun 15, 2008 at 5:55 PM, Bernhard Walle <bwalle@suse.de> wrote:
> * "Luming Yu" <luming.yu@gmail.com> [2008-06-15 17:26]:
>>
>> My git bisection result indicates the following commit causes the
>> kdump regression in 2.6.25-rc1:
>> commit 3c75e23784e6ed5f4841de43d0750fd9b37bafcb
>> Author: Andrew Patterson <andrew.patterson@hp.com>
>> Date:   Tue Jan 22 17:18:27 2008 -0700
>
> Can you verify that reverting that commit indeed fixes kdump at your
> site?

I've tested and can confirm reverting this commit resolves crash-boot
hang problem on my Coldfusion box. --Luming

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

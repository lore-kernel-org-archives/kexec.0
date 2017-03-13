Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cnM1a-0001Ma-OI
 for kexec@lists.infradead.org; Mon, 13 Mar 2017 09:12:20 +0000
Date: Mon, 13 Mar 2017 10:04:37 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] vmcore-dmesg: Define _GNU_SOURCE
Message-ID: <20170313090437.GB25077@verge.net.au>
References: <1452388882-11712-1-git-send-email-raj.khem@gmail.com>
 <1489002280.4347.149.camel@infradead.org>
 <20170310091210.GB21820@verge.net.au>
 <1489138715.3732.15.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1489138715.3732.15.camel@infradead.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Khem Raj <raj.khem@gmail.com>

On Fri, Mar 10, 2017 at 10:38:35AM +0100, David Woodhouse wrote:
> On Fri, 2017-03-10 at 10:12 +0100, Simon Horman wrote:
> > 
> > For some reason it did not hit my inbox :(
> > 
> > Shall I pick up the version you reposted as PATCH 7/7 ?
> 
> That works. There's a github PR too if that's easier to consume. Which
> wasn't *intended* to include this patch as it was for the uImage bits,
> but I made it from the wrong branch and didn't bother to redo it.

Thanks, its rather convenient for me that it did include the patch in
question. I have applied the series.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

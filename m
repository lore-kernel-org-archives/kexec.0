Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTPaC-00013W-BN
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 07:53:05 +0000
Date: Wed, 10 Feb 2016 08:52:40 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: readpage_elf: handle 0-pages not stored
 in the ELF file
Message-ID: <20160210085240.22e8aafa@hananiah.suse.cz>
In-Reply-To: <20160210032118.GI382@ycc.fr>
References: <20160122233514.GA25777@ycc.fr>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E19AFB@BPXM01GP.gisp.nec.co.jp>
 <20160127085821.3be424e1@hananiah.suse.cz>
 <20160127103741.0e4fec81@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E1B252@BPXM01GP.gisp.nec.co.jp>
 <20160201130042.5c83f7ae@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E1B6CE@BPXM01GP.gisp.nec.co.jp>
 <20160202070044.GN6903@ycc.fr>
 <20160209093150.35da61c2@hananiah.suse.cz>
 <20160210032118.GI382@ycc.fr>
MIME-Version: 1.0
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
To: Ivan Delalande <colona@arista.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, 10 Feb 2016 04:21:18 +0100
Ivan Delalande <colona@arista.com> wrote:

> Hi,
> 
> On Tue, Feb 09, 2016 at 09:31:50AM +0100, Petr Tesarik wrote:
>[...]
> > just a short status update. I haven't forgotten this patch, but I've
> > had some troubles reproducing the issue. To make sure I'm not on the
> > wrong track, what happened when you tried to dump dmesg on the affected
> > dump file without the patch?
> > 
> > For me, I crafted a dump file which causes a segfault. Did makedumpfile
> > also terminate on SIGSEGV? Did it report an error? Or did it just
> > produce wrong output?
> 
> Yeah, just a segfault, without any other message or output. It was
> coming from readpage_elf, at the call to memset in the `if (!offset1)`
> block, as it thinks it is handling one of this weird overlapping
> segments from ia64 and computes bad offsets.

Good. Then I was looking at the same bug, but fixed it differently.
Anyway, thank you very much for the original fix! It set me in the
right direction.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

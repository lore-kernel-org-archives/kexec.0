Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.guna.it ([217.22.246.228] helo=mail-antispam.guna.it)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MxHVn-0000cF-9n
	for kexec@lists.infradead.org; Mon, 12 Oct 2009 09:48:19 +0000
From: Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: Re: mips32 kexec failed, bug?
Date: Mon, 12 Oct 2009 11:48:01 +0200
References: <e997b7420910110732r36306a0flceeb03f8e059a95a@mail.gmail.com>
In-Reply-To: <e997b7420910110732r36306a0flceeb03f8e059a95a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200910121148.01514.francesco.chiechi@colibre.it>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: "wilbur.chan" <wilbur512@gmail.com>

I know that code can be somewhat imprecise, it used to work for me on a job 
Alessandro and I made for Tvblob

Actually I don't remember much about it, I contributed it in the hope it could 
be useful for othes, but once accepted I never had time to review it

If you feel you can improve it please do it

bye

Francesco

On Sunday 11 October 2009 16:32:39 wilbur.chan wrote:
> mips32 board:
>
>
> I used kexec to reboot a new kernel, but I found that , the second
> kernel stopped when calling 'prom_getenv("memsize") '  in booting.
>
>
> That is , kernel: setup_arch-->prom_init-->'prom_getenv("memsize")'  failed
>
>
> So I checked the code in kexec-tool , and I found that ,in
> mips-simple-setup.S,  register a2 was set to 0, which was passed to
> the second kernel as envirment variable address.
>
>
> I guess here a2 should not be set to 0 , is it a BUG in kexec-tool ,
> when dealing with mips?
>
>
> ps: I don't have mail address of the authors who wrote mips support
> for kexec ,  Francesco Chiechi, Alessandro Rubini , Tvblob s.r.l.
>
> So I wrote directly to this maillist to search for help.
>
> Thank you
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



-- 
Francesco Chiechi
Studio Associato Colibre - Consulenze GNU/Linux
via Tesio, 7
20151 Milano
fax    02 40910358
mobile 320 4730333

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

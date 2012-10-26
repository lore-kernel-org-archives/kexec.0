Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TRjp4-00065p-Jn
 for kexec@lists.infradead.org; Fri, 26 Oct 2012 13:19:40 +0000
Date: Fri, 26 Oct 2012 09:19:34 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Query regarding x86_64 purgatory and IA32-e compatibility mode
Message-ID: <20121026131934.GA24687@redhat.com>
References: <20121025205408.GB17995@redhat.com> <87lietq5zh.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87lietq5zh.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Thu, Oct 25, 2012 at 08:14:58PM -0700, Eric W. Biederman wrote:

[..]
> > I see that bit 21  in second doubleword is 0. IIUC, that means that we
> > will switch to compatibility mode. If yes, we are still continuing to
> > use 64bit instructions and continue to access registers (rip, r8-15)
> > which are available in 64bit mode only. Is this correct? How does this
> > work?
> 
>          /* 0x10 4GB flat code segment */
>         .word   0xFFFF, 0x0000, 0x9A00, 0x00AF
> 
> The high 16bits of that are:
> 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16
>  0  0  0  0  0  0  0  0  1  0  1  0  1  1  1  1
> 
> Since L is bit 21 I read that as L=1.
> 
> I don't know how you see L=1 there.

My bad. I did not take care of little endianness and read the bits in 
reverse order.
0x00AF

16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
 0  0  0  0  0  0  0  0  1  0  1  0  1  1  1  1

And concluded that bit 21 is 0.

> 
> The transition happens in entry64-32.S
> We get there via:
> 	jmp	*rip(%rip)
> 
> The default value of rip is entry32.
> 
> That is where we clear bit 21 in 
> 	ljmp	*lm_exit_addr(%rip)

Ok, now I understand. In entry64-32.S we load a different GDT 
where bit 21, L = 0. Hence long jump will put it in compatibility
mode.

0x00CF

31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16
 0  0  0  0  0  0  0  0  1  1  0  0  1  1  1  1

Thanks for explaining this.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

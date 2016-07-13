Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Wed, 13 Jul 2016 21:59:18 +0200
Message-ID: <5108278.va6WuahHro@wuerfel>
In-Reply-To: <2222184.ZN0KkkXgPC@hactar>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <7352796.seiSnHrYPy@wuerfel> <2222184.ZN0KkkXgPC@hactar>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

On Wednesday, July 13, 2016 3:45:41 PM CEST Thiago Jung Bauermann wrote:
> Am Mittwoch, 13 Juli 2016, 15:13:42 schrieb Arnd Bergmann:
> > On Wednesday, July 13, 2016 10:41:28 AM CEST Mark Rutland wrote:
> > > On Wed, Jul 13, 2016 at 10:01:33AM +0200, Arnd Bergmann wrote:
> > > > - kboot/petitboot with all of the user space being part of the trusted
> > > > boot> > 
> > > >   chain: it would be good to allow these to modify the dtb as needed
> > > >   without breaking the trust chain, just like we allow grub or u-boot
> > > >   to modify the dtb before passing it to the kernel.
> > > 
> > > It depends on *what* we need to modify here. We can modify the bootargs
> > > and initrd properties as part of the kexec_file_load syscall, so what
> > > else would we want to alter?
> > 
> > I guess petitboot can also just use kexec_load() instead of
> > kexec_file_load(), as long as the initramfs containing petitboot is
> > trusted by the kernel.
> 
> For secure boot, Petitboot needs to use kexec_file_load, because of the 
> following two features which the system call enables:
> 
> 1. only allow loading of signed kernels.
> 2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
>    command line and other boot inputs for the Integrity Measurement
>    Architecture subsystem.
> 
> Those can't be done with kexec_load.

Can't petitboot do both of these in user space?

	Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

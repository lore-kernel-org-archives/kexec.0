Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 18 Jul 2016 09:26:29 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160718132629.GB32512@redhat.com>
References: <20160712225805.0d27fe5d@hananiah.suse.cz>
 <20160712221804.GV1041@n2100.armlinux.org.uk>
 <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <87poqinf9m.fsf@linux.vnet.ibm.com>
 <20160713082639.GZ1041@n2100.armlinux.org.uk>
 <20160713130338.GB16900@redhat.com>
 <20160713174009.GA1041@n2100.armlinux.org.uk>
 <20160713182247.GA25232@redhat.com>
 <1468845964.2800.3.camel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1468845964.2800.3.camel@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com, arnd@arndb.de, kexec@lists.infradead.org, dyoung@redhat.com, Petr Tesarik <ptesarik@suse.cz>, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Mon, Jul 18, 2016 at 10:46:04PM +1000, Balbir Singh wrote:
> On Wed, 2016-07-13 at 14:22 -0400, Vivek Goyal wrote:
> > On Wed, Jul 13, 2016 at 06:40:10PM +0100, Russell King - ARM Linux wrot=
e:
> > >=A0
> > > On Wed, Jul 13, 2016 at 09:03:38AM -0400, Vivek Goyal wrote:
> > > >=A0
> > > > On Wed, Jul 13, 2016 at 09:26:39AM +0100, Russell King - ARM Linux =
wrote:
> > > > >=A0
> > > > > Indeed - maybe Eric knows better, but I can't see any situation w=
here
> > > > > the dtb we load via kexec should ever affect "the bootloader", un=
less
> > > > > the "kernel" that's being loaded into kexec is "the bootloader".
> > > > >=A0
> > > > > Now, going back to the more fundamental issue raised in my first =
reply,
> > > > > about the kernel command line.
> > > > >=A0
> > > > > On x86, I can see that it _is_ possible for userspace to specify a
> > > > > command line, and the kernel loading the image provides the comma=
nd
> > > > > line to the to-be-kexeced kernel with very little checking.=A0=A0=
So, if
> > > > > your kernel is signed, what stops the "insecure userspace" loading
> > > > > a signed kernel but giving it an insecure rootfs and/or console?
> > > > It is not kexec specific. I could do this for regular boot too, rig=
ht?
> > > >=A0
> > > > Command line options are not signed. I thought idea behind securebo=
ot
> > > > was to execute only trusted code and command line options don't enf=
orce
> > > > you to execute unsigned code.
> > > >=A0
> =

> You can set module.sig_enforce=3D0 and open up the system a bit assuming
> that you can get a module to load with another attack

IIUC, sig_enforce bool_enable_only so it can only be enabled. Default
value of it is 0 if CONFIG_MODULE_SIG_FORCE=3Dn.

IOW, if your kernel forced signature verification, you should not be
able to do sig_enforce=3D0. If you kernel did not have
CONFIG_MODULE_SIG_FORCE=3Dy, then sig_enforce should be 0 by default anyway
and you are not making it worse using command line.

> =

> > > > So it sounds like different class of security problems which you are
> > > > referring to and not necessarily covered by secureboot or signed
> > > > kernel.
> > > Let me give you an example.
> > >=A0
> > > You have a secure boot setup, where the firmware/ROM validates the bo=
ot
> > > loader.=A0=A0Good, the boot loader hasn't been tampered with.
> > >=A0
> > > You interrupt the boot loader and are able to modify the command line
> > > for the booted kernel.
> > >=A0
> > > The boot loader loads the kernel and verifies the kernel's signature.
> > > Good, the kernel hasn't been tampered with.=A0=A0The kernel starts ru=
nning.
> > >=A0
> > > You've plugged in a USB drive to the device, and specified a partition
> > > containing a root filesystem that you control to the kernel.=A0=A0The
> > > validated kernel finds the USB drive, and mounts it, and executes
> > > your own binaries on the USB drive.
> > You will require physical access to the machine to be able to
> > insert your usb drive. And IIRC, argument was that if attacker has
> > physical access to machine, all bets are off anyway.
> >
> =

> You don't need physical access -- your machine controller BMC can
> do the magic for you. So its not always physical access, is it?

Well, idea was that if you have physical access to machine, then all
bets are off. If BMC can do something which allows running unsigned
code at ring level 0, its a problem I think from secureboot model of
security.

> =A0
> > >=A0
> > >=A0
> > > You run a shell on the console.=A0=A0You now have control of the syst=
em,
> > > and can mount the real rootfs, inspect it, and work out what it does,
> > > etc.
> > >=A0
> > > At this point, what use was all the validation that the secure boot
> > > has done?=A0=A0Absolutely useless.
> > >=A0
> > > If you can change the command line arguments given to the kernel, you
> > > have no security, no matter how much you verify signatures.=A0=A0It's
> > > the illusion of security, nothing more, nothing less.
> > >=A0
> =

> I agree, if you can change command line arguments, all bets are of lesser=
 value

If changing command line allows execution of unsigned code at ring level
0, then it is a problem. Otherwise we are talking of security issues which
are not covered by secureboot model.

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

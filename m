Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 13 Jul 2016 16:36:32 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160713083632.GA14038@dhcp-128-65.nay.redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
 <20160712221804.GV1041@n2100.armlinux.org.uk>
 <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <87poqinf9m.fsf@linux.vnet.ibm.com>
 <20160713082639.GZ1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160713082639.GZ1041@n2100.armlinux.org.uk>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com, arnd@arndb.de, kexec@lists.infradead.org, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, vgoyal@redhat.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

[snip]
> Now, going back to the more fundamental issue raised in my first reply,
> about the kernel command line.
> 
> On x86, I can see that it _is_ possible for userspace to specify a
> command line, and the kernel loading the image provides the command
> line to the to-be-kexeced kernel with very little checking.  So, if
> your kernel is signed, what stops the "insecure userspace" loading
> a signed kernel but giving it an insecure rootfs and/or console?

The kexec_file_load syscall was introduced for secure boot in the first
place. In case UEFI secure boot the signature verification chain only
covers kernel mode binaries. I think there is such problem in both normal
boot and kexec boot.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

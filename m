Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Wed, 13 Jul 2016 21:57:28 +0200
Message-ID: <7927804.6bj1abO0d2@wuerfel>
In-Reply-To: <20160713175630.GA2668@leverpostej>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160713173804.GA25723@porco> <20160713175630.GA2668@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, bauerman@linux.vnet.ibm.com, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Wednesday, July 13, 2016 6:58:32 PM CEST Mark Rutland wrote:
> 
> >   we may want to remove unnecessary devices and even add a dedicated
> >   storage device for storing a core dump image.
> 
> I suspect that bringing up a minimal number of devices is better
> controlled by a cmdline option. In general, figuring out what is
> necessary and what is not is going to be board specific, so hacking the
> FW tables (DTB or ACPI) is not a very portable/reliable approach.
> 
> Do we actually add devices in practice? More so than the above that
> requires special knowledge of the platform (including things that were
> not described in the boot DTB).
> 
> In the ACPI case modifying a DTB alone is not sufficient to change the
> information regarding devices, as those won't be described in the DTB.
> It's not possible to convert ACPI to DTB in general.

A more likely scenario would be replacing ACPI tables with a DTB that
describes the platform in order to use devices that the ACPI tables
don't contain.

> > - Say, booting BE kernel on ACPI LE kernel
> >   In this case, there is no useful dtb in the kernel.

> If the platform only has ACPI, then you cannot boot a BE kernel to begin
> with. As above one cannot convert ACPI to DTB, so one would need
> extensive platform knowledge for this to work.

I think what he meant was to pass a DTB to the kexec kernel in order
to run BE, while the original kernel can only run LE due to ACPI.

If you boot a LE kernel using DTB, the same DTB should work
for a kexec boot for a BE kernel.

	Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

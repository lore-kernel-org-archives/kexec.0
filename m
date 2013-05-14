Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pb0-x230.google.com ([2607:f8b0:400e:c01::230])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcNlX-0002FQ-13
 for kexec@lists.infradead.org; Tue, 14 May 2013 22:32:15 +0000
Received: by mail-pb0-f48.google.com with SMTP id md4so808189pbc.35
 for <kexec@lists.infradead.org>; Tue, 14 May 2013 15:31:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k3n1w7a5.fsf@xmission.com>
References: <CAKw_n9E=Hf0=ao1+tjbarHhQoJUdw70xhTUFaY_s4g3OARpdMg@mail.gmail.com>
 <87k3n1w7a5.fsf@xmission.com>
Date: Tue, 14 May 2013 17:25:26 -0500
Message-ID: <CAKw_n9H99M-5QaNvRdXk6iKSQiChAC60U_f=C_yJGwpb0vFDaA@mail.gmail.com>
Subject: Re: Kernel panics when using kexec for rebooting
From: Dave Lloyd <dave@davelloyd.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org

On Tue, May 14, 2013 at 5:01 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:

>
> Yes this does seem to be all over the place, and memory corruption
> probably caused by ongoing-dma seems like a reasonable hypothesis.

Thank goodness it's not just me! :-)

>
> The easy first thing to try is to remove all of your kernel modules
> before you reboot with kexec.  Not infrequently the module remove path
> is better tested than the device shutdown path.

I'm trying this now. In one panic, the pte referenced was
0x100010000000000 which sure looks a whole like someone wrote his
registers in there. It certainly doesn't look like a valid pte.

So far, unloading pata_acpi and pata_amd seem to have eliminated the
ACPI exception messages. I believe that this resets the device
properly. Unfortunately, it looks like lots of drivers don't implement
the pci_driver->shutdown call, so it would make sense that this is a
relatively widespread problem.

--dlloyd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

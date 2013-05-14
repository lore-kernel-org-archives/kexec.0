Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcNI7-0001gR-M9
 for kexec@lists.infradead.org; Tue, 14 May 2013 22:01:53 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <CAKw_n9E=Hf0=ao1+tjbarHhQoJUdw70xhTUFaY_s4g3OARpdMg@mail.gmail.com>
Date: Tue, 14 May 2013 15:01:06 -0700
In-Reply-To: <CAKw_n9E=Hf0=ao1+tjbarHhQoJUdw70xhTUFaY_s4g3OARpdMg@mail.gmail.com>
 (Dave Lloyd's message of "Mon, 13 May 2013 10:40:09 -0500")
Message-ID: <87k3n1w7a5.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: Kernel panics when using kexec for rebooting
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
To: Dave Lloyd <dave@davelloyd.com>
Cc: kexec@lists.infradead.org

Dave Lloyd <dave@davelloyd.com> writes:

> All:
>
> I seem to be able to relatively reliably panic a system when using
> kexec to reboot. This does not happen during a normal boot sequence.
> Unfortunately, the stack trace I get for the panic is not consistent.
> I've included a few here. Mostly they seem to center on what smells
> like some sort of memory corruption to me. I'm kind of banging my head
> against the wall with this, so any help would be greatly appreciated.

Yes this does seem to be all over the place, and memory corruption
probably caused by ongoing-dma seems like a reasonable hypothesis.

The easy first thing to try is to remove all of your kernel modules
before you reboot with kexec.  Not infrequently the module remove path
is better tested than the device shutdown path.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.emea.novell.com ([130.57.118.101])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsQZo-0007A2-8d
 for kexec@lists.infradead.org; Wed, 13 May 2015 06:55:37 +0000
Message-Id: <5553116A0200007800079D2D@mail.emea.novell.com>
Date: Wed, 13 May 2015 07:55:06 +0100
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: More on kexec/purgatory handover
References: <20150509152159.6b391c2b@hananiah.suse.cz><20150509152159.6b391c2b@hananiah.suse.cz>
 (Petr Tesarik's message of "Sat, 9 May 2015 15:21:59 +0200")
 <87y4ktjbe8.fsf@x220.int.ebiederm.org>
In-Reply-To: <87y4ktjbe8.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Disposition: inline
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Petr Tesarik <ptesarik@suse.cz>, xen-devel@lists.xen.org

>>> On 13.05.15 at 07:26, <ebiederm@xmission.com> wrote:
> The low 640k was weird.   We copied it off in purgatory so that it could
> be capture in a dump.  The linux kernel itself winds up using that
> memory fundamentally because to fire up subsequent processors you have
> to have memory in the low 640k as processors start in real-mode and
> the startup IPI only takes an address in the low 1M.  I also remember
> things with interrupt descriptor tables.

Right, but the point to clarify is whether it is reasonable for the
purgatory and/or new kernel to expect the old kernel to set up
mappings for special regions like this one. As said before - I don't
think this should be done; the old (possibly half broken) kernel
shouldn't be forced to do any more than the absolute minimum
amount of work to be able to transfer control.

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

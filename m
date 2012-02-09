Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RvVJ1-0004He-3p
 for kexec@lists.infradead.org; Thu, 09 Feb 2012 14:49:04 +0000
Date: Thu, 9 Feb 2012 09:48:57 -0500
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86, kdump: No need to disable ioapic in crash path
Message-ID: <20120209144857.GC5650@redhat.com>
References: <1328206323-25580-1-git-send-email-dzickus@redhat.com>
 <m1r4ycsts1.fsf@fess.ebiederm.org>
 <20120207215741.GD5650@redhat.com>
 <20120207221924.GH6346@redhat.com>
 <m1r4y6i5cw.fsf@fess.ebiederm.org>
 <20120208201145.GX5650@redhat.com>
 <m1sjilc4vh.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1sjilc4vh.fsf@fess.ebiederm.org>
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
Cc: x86@kernel.org, kexec-list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Feb 08, 2012 at 02:55:14PM -0800, Eric W. Biederman wrote:
> > I ran lkdtm by panic'ing in the interrupt handle thus leaving device
> > interrupt un-ack'd and the apic might have been un-ack'd too (jprobes
> > hooked in at do_IRQ).  3 out 3 times the second kernel came up on my core2
> > quad.
> 
> That sounds like more than enough basic testing for me.  Document your
> testing in a patch description and let's get the unnecessary local apic
> and ioapic stomping removed from the kexec on panic path.
> 
> There were bugs.  We deleted the code that had them.  The bugs are gone
> and there are no new problems goes over very well in my book.

Great.  Thanks.  I'll put together the patch.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

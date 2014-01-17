Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from gate.crashing.org ([63.228.1.57])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W42T9-0007qA-7e
 for kexec@lists.infradead.org; Fri, 17 Jan 2014 05:59:52 +0000
Message-ID: <1389938353.7406.22.camel@pasglop>
Subject: Re: [Q] Why does kexec use device_shutdown rather than ubind them
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 17 Jan 2014 16:59:13 +1100
In-Reply-To: <871u07fbvl.fsf@xmission.com>
References: <1389929988.7406.18.camel@pasglop> <871u07fbvl.fsf@xmission.com>
Mime-Version: 1.0
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
Cc: Matthew Garrett <matthew.garrett@nebula.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2014-01-16 at 20:52 -0800, Eric W. Biederman wrote:
> 
> I think we have largely survied until now because kdump is so popular
> and kdump winds up having to reinitialize devices from any random
> state.

kdump also doesn't care too much if the device is still DMA'ing to the
old kernel memory :-)

> But like I said I am all for reducing the burden on device driver
> developers.

Right. I'm experimenting with a variant of device_shutdown() that tries
remove() first and if it doesn't exist and shutdown() does, call that
(is that ever the case ?). I'm keeping this kexec-specific for now.

I'll try to hammer that on some of our machines see if it breaks
anything, I think it's a much better approach for kexec.

As for actual machine shutdown, we *might* have some corner cases where
shutdown is actually different from remove for good reasons, so that
will have to be investigated a bit more in depth.

I'll post my results when I have them.

Cheers,
Ben.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

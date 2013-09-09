Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ud10.udmedia.de ([194.117.254.50] helo=mail.ud10.udmedia.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VIxfZ-00007n-6c
 for kexec@lists.infradead.org; Mon, 09 Sep 2013 09:22:06 +0000
Date: Mon, 9 Sep 2013 11:21:40 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH 0/3] drm/radeon kexec fixes
Message-ID: <20130909092140.GA359@x4>
References: <20130908120947.GA360@x4>
 <87bo42eswi.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bo42eswi.fsf@xmission.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>, kexec@lists.infradead.org, dri-devel@lists.freedesktop.org

On 2013.09.08 at 17:32 -0700, Eric W. Biederman wrote:
> Markus Trippelsdorf <markus@trippelsdorf.de> writes:
> 
> > Here are a couple of patches that get kexec working with radeon devices.
> > I've tested this on my RS780. 
> > Comments or flames are welcome.
> > Thanks.
> 
> A couple of high level comments.
> 
> This looks promising for the usual case.
> 
> Removing the printk at the end of the kexec path seems a little dubious,
> what of other cpus, interrupt handlers, etc.  Basically estabilishing a
> new rule on when printk is allowed seems a little dubious at this point,
> even if it is a useful debugging trick.

OK. I will drop this patch. It doesn't seem to be necessary, because I
cannot reproduce the printk related hang anymore.

> Having a clean shutdown of the radeon definitely seems worth doing,
> because the cases where we care abouty video are when a person is in
> front of the system.

Yes. But please note that even with radeon_pci_shutdown implemented, I
still get ring test failures on roughly every eighth kexec boot:

 [drm:r600_dma_ring_test] *ERROR* radeon: ring 3 test failed (0xCAFEDEAD)                                                                           
 radeon 0000:01:05.0: disabling GPU acceleration  

That's definitely better than the current state of affairs, with ring
test failures on every second boot. But I haven't figured out the reason
for these failures yet. It's curious that once a ring test failure
occurs, it will reliably fail after each kexec invocation, no matter how
often repeated. Only a reboot brings the machine back to normal.

> I don't know if you want to remove the sanity checks.  They seem cheap
> and safe regardless.  Are they expensive or ineffective?  Moreover if
> they work a reasonable amount of the time that means that the kexec on
> panic case (where we don't shut anything down) can actually use the
> video, and that in general the driver will be more robust.  I don't
> expect anyone much cares as kexec on panic is mostly used to just write
> a core file to the network, or the local disk.  But if it is easy to
> keep that case working most of the time, why not.

IIRC Alex said the sanity checks are expensive and boot-time could be
improved by dropping them. Maybe he can chime in?

-- 
Markus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

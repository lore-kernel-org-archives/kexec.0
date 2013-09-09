Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mxout.vodafone.de ([80.84.1.40] helo=smtp-02.vodafone.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VIxxI-0000WM-Fe
 for kexec@lists.infradead.org; Mon, 09 Sep 2013 09:40:25 +0000
Message-ID: <522D972D.5090805@vodafone.de>
Date: Mon, 09 Sep 2013 11:38:53 +0200
From: =?ISO-8859-1?Q?Christian_K=F6nig?= <deathsimple@vodafone.de>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] drm/radeon kexec fixes
References: <20130908120947.GA360@x4> <87bo42eswi.fsf@xmission.com>
 <20130909092140.GA359@x4>
In-Reply-To: <20130909092140.GA359@x4>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, dri-devel@lists.freedesktop.org

Am 09.09.2013 11:21, schrieb Markus Trippelsdorf:
> On 2013.09.08 at 17:32 -0700, Eric W. Biederman wrote:
>> Markus Trippelsdorf <markus@trippelsdorf.de> writes:
>>
>>> Here are a couple of patches that get kexec working with radeon devices.
>>> I've tested this on my RS780.
>>> Comments or flames are welcome.
>>> Thanks.
>> A couple of high level comments.
>>
>> This looks promising for the usual case.
>>
>> Removing the printk at the end of the kexec path seems a little dubious,
>> what of other cpus, interrupt handlers, etc.  Basically estabilishing a
>> new rule on when printk is allowed seems a little dubious at this point,
>> even if it is a useful debugging trick.
> OK. I will drop this patch. It doesn't seem to be necessary, because I
> cannot reproduce the printk related hang anymore.
>
>> Having a clean shutdown of the radeon definitely seems worth doing,
>> because the cases where we care abouty video are when a person is in
>> front of the system.
> Yes. But please note that even with radeon_pci_shutdown implemented, I
> still get ring test failures on roughly every eighth kexec boot:
>
>   [drm:r600_dma_ring_test] *ERROR* radeon: ring 3 test failed (0xCAFEDEAD)
>   radeon 0000:01:05.0: disabling GPU acceleration
>
> That's definitely better than the current state of affairs, with ring
> test failures on every second boot. But I haven't figured out the reason
> for these failures yet. It's curious that once a ring test failure
> occurs, it will reliably fail after each kexec invocation, no matter how
> often repeated. Only a reboot brings the machine back to normal.

The main problem here is that the AMD gfx hardware doesn't really 
support being reinitialized once booted (for various reasons). It's a 
(intended) limitation of the hardware design that you can only 
initialize certain blocks once every power cycle, so the whole approach 
actually will never work 100% reliable.

All you can hope for is that stopping the hardware while shutting down 
the old kernel and starting it again results in exactly the same 
hardware parameters (offsets, clock etc...) otherwise starting the 
blocks will just fail and you end up with disabled acceleration like above.

Sorry, but there isn't much we can do about this,
Christian.

>> I don't know if you want to remove the sanity checks.  They seem cheap
>> and safe regardless.  Are they expensive or ineffective?  Moreover if
>> they work a reasonable amount of the time that means that the kexec on
>> panic case (where we don't shut anything down) can actually use the
>> video, and that in general the driver will be more robust.  I don't
>> expect anyone much cares as kexec on panic is mostly used to just write
>> a core file to the network, or the local disk.  But if it is easy to
>> keep that case working most of the time, why not.
> IIRC Alex said the sanity checks are expensive and boot-time could be
> improved by dropping them. Maybe he can chime in?
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

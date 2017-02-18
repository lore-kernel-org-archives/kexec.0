Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nuclearcat.com ([144.76.183.226])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cf05l-0002Yv-Oi
 for kexec@lists.infradead.org; Sat, 18 Feb 2017 08:10:07 +0000
MIME-Version: 1.0
Date: Sat, 18 Feb 2017 10:09:39 +0200
From: Denys Fedoryshchenko <nuclearcat@nuclearcat.com>
Subject: Re: kexec on panic
In-Reply-To: <23681d9b-fec9-8ec7-3772-db5b36da9725@jonmasters.org>
References: <52a88de81ea3c62bb2be9e222eb85805@nuclearcat.com>
 <23681d9b-fec9-8ec7-3772-db5b36da9725@jonmasters.org>
Message-ID: <8dee042080bf3a00d376afc271b050eb@nuclearcat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jon Masters <jcm@jonmasters.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 2017-02-18 09:42, Jon Masters wrote:
> Hi Denys,
> 
> On 02/10/2017 03:14 AM, Denys Fedoryshchenko wrote:
> 
>> After years of using kexec and recent unpleasant experience with 
>> modern (supposed to be blazing fast to boot) hardware that need 5-10 
>> minutes just to pass POST tests,
>> one question came up to me:
>> Is it possible anyhow to execute regular (not special "panic" one to 
>> capture crash data) kexec on panic to reduce reboot time?
> 
> Generally, you don't want to do this, because various platform hardware
> might be in non-quiescent states (still doing DMA to random memory, 
> etc.)
> and other nastiness that means you don't want to do more than the 
> minimal
> amount in a kexec on panic (crash). We've seen no end of fun and games
> even with just regular crash dumps while hardware is busily writing to
> memory that it shouldn't be. An IOMMU helps, but isn't a cure-all.
> 
> Jon.
Well, i have to try, even sometimes i am facing issues with non-booting 
hardware even on regular kexec, but having at small customer HP server 
that need almost 6 minutes to boot,
no hot-spare(and hard to do by many reasons, no spare 10G ports, cost of 
hardware and etc) and some nasty bugs that is not resolved yet - forcing 
me to search way to reduce reboot time.
If i will find way to save backtrace and reboot fast, it will help a lot 
to debug kernels with minimal downtime, if bug is reproducible only on 
live system.

What i did now, might be insanely wrong, but:
diff -Naur linux-4.9.9-vanilla/kernel/kexec_core.c 
linux-4.9.9/kernel/kexec_core.c
--- linux-4.9.9-vanilla/kernel/kexec_core.c	2017-02-09 
07:08:40.000000000 +0000
+++ linux-4.9.9/kernel/kexec_core.c	2017-02-17 12:54:49.000000000 +0000
@@ -897,6 +897,10 @@
  			machine_crash_shutdown(&fixed_regs);
  			machine_kexec(kexec_crash_image);
  		}
+		if (kexec_image) {
+		    machine_shutdown();
+		    machine_kexec(kexec_image);
+		}
  		mutex_unlock(&kexec_mutex);
  	}
  }

Then

kexec -l /mnt/flash/kernel --append="intel_idle.max_cstate=0 
processor.max_cstate=1"

and
echo c >/proc/sysrq-trigger
worked even on busy network router, but i'm not sure it will be same on 
real networking stack crash.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

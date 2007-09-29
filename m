Return-path: <kexec-bounces@lists.infradead.org>
Received: from outbound.mse2.exchange.ms ([69.25.50.247]
	helo=mse2fe1.mse2.exchange.ms)
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IbQGj-0002HF-TI
	for kexec@lists.infradead.org; Sat, 29 Sep 2007 01:33:22 +0100
Message-ID: <46FD9D2E.3020504@bluelane.com>
Date: Fri, 28 Sep 2007 17:32:46 -0700
From: Pete/Piet Delaney <pete@bluelane.com>
MIME-Version: 1.0
Subject: Re: [Kgdb-bugreport] Problem getting kgdb to read kernel symbols.
	addresses shifted?
References: <sjmabr8j6d7.fsf@pgpdev.ihtfp.org>	<46FD03CD.9060404@windriver.com>
	<sjmve9uj3d2.fsf@pgpdev.ihtfp.org>	<46FD1B6A.3000500@windriver.com>	<20070928114522.n0cdrcebykkgg408@webmail.mit.edu>	<46FD2CFB.9010404@windriver.com>
	<46FD75E1.3090602@bluelane.com>	<m18x6qbfip.fsf@ebiederm.dsl.xmission.com>	<sjm641uid1x.fsf@pgpdev.ihtfp.org>	<m11wcibbpq.fsf@ebiederm.dsl.xmission.com>
	<sjmodfmgx5q.fsf@pgpdev.ihtfp.org>
In-Reply-To: <sjmodfmgx5q.fsf@pgpdev.ihtfp.org>
Reply-To: Piet Delaney <pdelaney@bluelane.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Cc: Dave Anderson <anderson@redhat.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Derek Atkins wrote:

Dave, I thought you would likely know what's going on here.
How about helping out Derek? Sounds like a RedHat'ism and
I kinda recall your mentioning it and apologizing for it
as an unfortunate RedHat directive.

- -piet

> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
>> Derek Atkins <warlord@MIT.EDU> writes:
>>
>>> Well, gdb agrees with System.map, so I'm sure that gdb itself is
>>> okay.  It's certainly possible that that the kgdb stub is weird,
>>> but /proc/kallsyms doesn't match System.map, and THAT'S what's
>>> confusing me most of all.
>> Ok.  So we must have a relocatable kernel that figures it has been
>> relocated.  Interesting.  
>>
>> What is your bootloader?
> 
> GRUB
> 
>> What is your kernel version?
> 
> 2.6.22.5-76_kgdb0.fc7-i686
> 
>> What is your kernel config?
> 
> See the attached .config file.
> 
>> The only time I would expect to see what you are seeing is if
>> you are debugging the kdump kernel, which doesn't sound like
>> the case.
> 
> Nope.  I started with the Fedora 'i686' config and then patched
> in the kgdb patches and configuration.
> 
>> If we actually have a truly offset kernel then while things
>> may not be perfect this is at least expected.  I don't think
>> I have heard of anyone handling this case very well.
> 
> :(   Like I said before, it SEEMS to work okay by telling GDB
> to load in at a different address.
> 
>>> Which was how long ago?  ;)
>> Long enough ago that I don't remember when ;)
> 
> Heh.
> 
>> Eric
> 
> -derek
> 
> 
> 
> ------------------------------------------------------------------------
> 
> 
> 
> ------------------------------------------------------------------------
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Kgdb-bugreport mailing list
> Kgdb-bugreport@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG/Z0uJICwm/rv3hoRAl1uAJ9QoR5DhfUGCccgz9KFpEpHkbvaaACdGG2z
9LxB5RdtsUi9IrTKzbPpB1U=
=gQee
-----END PGP SIGNATURE-----

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

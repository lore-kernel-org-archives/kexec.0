Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TiELA-0005R2-Fs
 for kexec@lists.infradead.org; Tue, 11 Dec 2012 01:08:57 +0000
Subject: Re: [RFC] makedumpfile-1.5.1 RC
From: Lisa Mitchell <lisa.mitchell@hp.com>
In-Reply-To: <20121207142646.9c4b3dd78ab602d687194f65@mxc.nes.nec.co.jp>
References: <20121116171539.152467f3611c12fbd6b6be0d@mxc.nes.nec.co.jp>
 <1353413695.13097.131.camel@lisamlinux.fc.hp.com>
 <1354627899.13097.320.camel@lisamlinux.fc.hp.com>
 <20121207142646.9c4b3dd78ab602d687194f65@mxc.nes.nec.co.jp>
Date: Mon, 10 Dec 2012 14:06:05 -0700
Message-ID: <1355173565.13097.525.camel@lisamlinux.fc.hp.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Hoemann,
 Jerry" <jerry.hoemann@hp.com>

On Fri, 2012-12-07 at 05:26 +0000, Atsushi Kumagai wrote:

> As you may understand, the number of cycle is two (or larger) in your
> test (2.). And it seems that you used free_list logic because you
> specified neither -x vmlinux option nor -i vmcoreinfo_text_file option.
> (Please see release note for how to use mem_map array logic.)
> 
>   http://lists.infradead.org/pipermail/kexec/2012-December/007460.html
> 
> This combination means that redundant scans was done in your test,
> I think makedumpfile-v1.5.1-rc couldn't show the best performance we expected.
> 
> So, could you do the same test with v1.5.1-GA (but, the logic isn't different
> from rc) and -i vmcoreinfo_text_file option ? We should see its result and
> discuss it.
> 
> In addition, you need to include vmcoreinfo_text_file in initramfs in order
> to use -i option. If you have RedHat OS, you can refer to /sbin/mkdumprd
> to know how to do it.
> 
> 
> Thanks
> Atushi Kumagai

Atushi, I put the kernel patch from https://lkml.org/lkml/2012/11/21/90
that you had in the release notes, along with the modifications you
specified for a 2.6.32 kernel in
http://lists.infradead.org/pipermail/kexec/2012-December/007461.html
on my RHEL 6.3 kernel source, and built a patched kernel in order to
hopefully enable use of the mem map array logic feature during my dump
testing.

I do not have the use of the 4 TB system again, so I constrained a 256
GB system to a crashkernel size of 136M, which would cause the cyclic
buffer feature to be used and timed some dumps.  

I compared the dump time on the system with the makedumpfile 1.4 version
that ships with RHEL 6.3, using crashkernel=256M to contain the full
bitmap, to both the patched and unpatched kernels using
makedumpfilev1.5.1GA.  Here were the results, using the file timestamps.
All dumps were taken with core_collector makedumpfile -c --message-level
1 -d 31


1.  RHEL 6.3 2.6.32.279 kernel, makedumpfile 1.4, crashkernel=256M
 ls -al --time-style=full-iso 127.0.0.1-2012-12-10-16:44 
total 802160
drwxr-xr-x.  2 root root      4096 2012-12-10 16:51:36.909648053 -0700 .
drwxr-xr-x. 12 root root      4096 2012-12-10 16:44:59.213529059
-0700 ..
-rw-------.  1 root root 821396774 2012-12-10 16:51:36.821529854 -0700
vmcore

Time to write out the dump file: 6.5 minutes


2. RHEL 6.3 2.6.32.279 kernel, makedumpfile 1.5.1GA, crashkernel=136M

 ls -al --time-style=full-iso 127.0.0.1-2012-12-10-15:17:18
total 806132
drwxr-xr-x.  2 root root      4096 2012-12-10 15:27:28.799600723 -0700 .
drwxr-xr-x. 11 root root      4096 2012-12-10 15:17:19.202329188
-0700 ..
-rw-------.  1 root root 825465058 2012-12-10 15:27:28.774327293 -0700
vmcore

Time to write out the dump file:  10 minutes, 10 seconds

3. Patched RHEL 6.3 kernel, makedumpfile 1.5.1GA, crashkernel=136M

ls -al --time-style=full-iso 127.0.0.1-2012-12-10-14:42 ^M:28^M
total 808764^M
drwxr-xr-x.  2 root root      4096 2012-12-10 14:50:04.263144379
-0700 .^M
drwxr-xr-x. 10 root root      4096 2012-12-10 14:42:29.230903264
-0700 ..^M
-rw-------.  1 root root 828160709 2012-12-10 14:50:04.212739485 -0700
vmcore^M

Time to write out the dump file: 7.5 minutes


The above indicates that with the kernel patch we got a dump file write
time  2 minutes shorter than using makedumpfile 1.5.1 without the kernel
patch.  However, with the kernel patch (and hopefully this enabled the
mem map array logic feature)  I still got a dump time that was about 2
minutes longer, or in this case about 30% longer than the old
makedumpfile 1.4, using the full bitmap.  

So I still see a regression, which will have to be projected to the
multi TB systems.

Atushi, am I using the new makedumpfile 1.5.1GA correctly with the
kernel patch? 

I didn't understand how to use the options of makedumpfile you
mentioned, and when I tried with a vmlinux file, and the -x option,
makedumpfile didn't even start, just failed and reset. 

I was hoping with the kernel patch in place, that with the default
settings of makedumpfile, the mem map array logic would automatically be
used.  If not, I am still puzzled as to how to invoke it. 






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

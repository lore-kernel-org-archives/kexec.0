Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TfwOB-00085d-7D
 for kexec@lists.infradead.org; Tue, 04 Dec 2012 17:34:36 +0000
Subject: Re: [RFC] makedumpfile-1.5.1 RC
From: Lisa Mitchell <lisa.mitchell@hp.com>
In-Reply-To: <1353413695.13097.131.camel@lisamlinux.fc.hp.com>
References: <20121116171539.152467f3611c12fbd6b6be0d@mxc.nes.nec.co.jp>
 <1353413695.13097.131.camel@lisamlinux.fc.hp.com>
Date: Tue, 04 Dec 2012 06:31:39 -0700
Message-ID: <1354627899.13097.320.camel@lisamlinux.fc.hp.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jerry.hoemann@hp.com

On Tue, 2012-11-20 at 05:14 -0700, Lisa Mitchell wrote:

> 
> 
> I tested this makedumpfile v1.5.1-rc on a 4 TB DL980, on 2.6.32 based
> kernel, and got good results. With crashkernel=256M, and default
> settings (i.e. no cyclic buffer option selected), the dump successfully
> completed in about 2 hours, 40 minutes, and then I specified a cyclic
> buffer size of 48 M, and the dump completed in the same time, no
> measurable differences within the accuracy of our measurements. 
> 
> We are still evaluating perfomance data, and don't have very precise
> measurements here for comparisons, but the results look promising so
> far.   
> 
> Lisa Mitchell

Update:

 I did another test over the last few days that was a better apples-to-
apples comparison, contrasting the performance of makedumpfile 1.4  with
makedumpfile v1.5.1-rc on a RHEL 6.3 system with 4 TB of memory.

Earlier I had not taken good comparable measurements of the dump times,
from the exact same machine configuration comparisons of the timing
differences between the two makedumpfiles.  I had noted that
makedumpfile 1.5.1-rc seemed a performance improvemnt over makedumpfile
v1.5.0 results seen earlier.

Unfortunately this weekend, the results showed a significant performance
regression still with makedumpfile v1.5.1-rc compared to makedumpfile
1.4 

This time my performance measurements were based on comparing the file
system timestamps in the /var/crash directory, showing the difference
from when the crash directory was created by makedumpfile, to the
timestamp on the vmcore file, to show when the copy of the memory to
this file was complete. 

1. Baseline:  On the 4 TB DL980, with the RHEL 6.3 installation,(2.6.32
based kernel) with a crashkernel size of 512M or 384M  (both big enough
to contain the 256M bit map required, plus the kernel).The makedumpfile
command line was the same for both tests: " -c --message-level 1 -d 31"
The timestamps shown for the dump copy were:

# cd /var/crash
# ls
127.0.0.1-2012-11-30-15:28:22
# cd 127.0.0.1-2012-11-30-15:28:22
#ls -al 127.0.0.1-2012-11-30-15:28:22
total 10739980^M
drwxr-xr-x. 2 root root        4096 Nov 30 17:07 .^M
drwxr-xr-x. 3 root root        4096 Nov 30 15:28 ..^M
-rw-------. 1 root root 10997727069 Nov 30 17:07 vmcore

From the time stamps above the dump started at 15:28, completed at
17:07, the dump time was 1 hour, 41 minutes.

2. Makedumpfile-v1.5.1-rc on the same system configuration as (1.)
above, but with crashkernel size set to 256 M to insure the use of the
cyclic buffer feature to fit in smaller crashkernel space.  The same
makedumpfile command line of "-c --message-level 1 -d 31" was used.

#cd /var/crash
# ls -al
total 12
drwxr-xr-x.  3 root root 4096 Nov 30 23:25 .
drwxr-xr-x. 22 root root 4096 Nov 30 08:41 ..
drwxr-xr-x.  2 root root 4096 Dec  1 02:05 127.0.0.1-2012-11-30-23:25:20

#ls -al *
total 10734932
drwxr-xr-x. 2 root root        4096 Dec  1 02:05 .
drwxr-xr-x. 3 root root        4096 Nov 30 23:25 ..
-rw-------. 1 root root 10992554141 Dec  1 02:05 vmcore

From the timestamps above, the dump started at 23:25 and completed at
2:05 after midnight, so the total dump time was 2 hours and 40 minutes.

So for this 4 TB system, in this test, the dump write phase took 1 hour
longer for makedumpfile-v1.5.1-rc, versus makedumpfile v1.4. This time
seems dominated by the dump filtering activity, assuming the  copy to
disk times should have been the same, though I don't have a good
breakdown. 

I look forward to the GA version of makedumpfile v1.5.1 to see if there
are any improvements, but it now looks to me like there are still a lot
of improvements needed before v1.5.1 will have performance parity with
v1.4

Has anyone else done performance comparisons on multi-terabyte systems
between makedumpfile 1.5.1 and makedumpfile 1.4, to see if others get
similar results, or if my measurement method is inaccurate?








_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

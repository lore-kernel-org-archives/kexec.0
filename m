Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V2gQR-0006Yn-FW
 for kexec@lists.infradead.org; Fri, 26 Jul 2013 11:43:12 +0000
Message-ID: <51F260AF.7010409@hp.com>
Date: Fri, 26 Jul 2013 19:42:39 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: makedumpfile 1.5.4 + kernel 3.11-rc2+ 4TB tests
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Wang, Jin (Steven)" <jin.wang@hp.com>, Jingbai Ma <jingbai.ma@hp.com>, "Mitchell, Lisa (MCLinux in Fort Collins)" <lisa.mitchell@hp.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "kumagai-atsushi@mxc.nes.nec.co.jp" <kumagai-atsushi@mxc.nes.nec.co.jp>, "Eric W. Biederman" <ebiederm@xmission.com>, "Croxon,
 Nigel" <nigel.croxon@hp.com>, cpw@sgi.com, Vivek Goyal <vgoyal@redhat.com>

Hi,

I have run some tests with makedumpfile 1.5.4 and upstream kernel 
3.11-rc2+ on a machine with 4TB memory, here is testing results:

Test environment:
Machine: HP ProLiant DL980 G7 with 4TB RAM.
CPU: Intel(R) Xeon(R) CPU E7- 2860  @ 2.27GHz (8 sockets, 10 cores)
(Only 1 CPU was enabled the 2nd kernel)
Kernel: 3.11.0-rc2+ (at patch b3a3a9c441e2c8f6b6760de9331023a7906a4ac6)
crashkernel=384MB
vmcore size: 4.0TB
Dump file size: 15GB
All measured time from debug message of makedumpfile.
As a comparison, I also have tested makedumpfile 1.5.3.

(all time in seconds)
                      Excluding pages   Copy data   Total
makedumpfile 1.5.3          468         1182       1650
makedumpfile 1.5.4           93          518        611


So it seems there is a great performance improvement by the mmap mechanism.

--
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

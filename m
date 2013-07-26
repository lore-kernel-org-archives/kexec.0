Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V2i07-0002eK-0F
 for kexec@lists.infradead.org; Fri, 26 Jul 2013 13:24:08 +0000
Date: Fri, 26 Jul 2013 09:23:35 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile 1.5.4 + kernel 3.11-rc2+ 4TB tests
Message-ID: <20130726132335.GA27529@redhat.com>
References: <51F260AF.7010409@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51F260AF.7010409@hp.com>
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
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Wang,
 Jin (Steven)" <jin.wang@hp.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mitchell,
 Lisa (MCLinux in Fort Collins)" <lisa.mitchell@hp.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "kumagai-atsushi@mxc.nes.nec.co.jp" <kumagai-atsushi@mxc.nes.nec.co.jp>, "Eric W. Biederman" <ebiederm@xmission.com>, "Croxon,
 Nigel" <nigel.croxon@hp.com>, cpw@sgi.com

On Fri, Jul 26, 2013 at 07:42:39PM +0800, Jingbai Ma wrote:
> Hi,
> 
> I have run some tests with makedumpfile 1.5.4 and upstream kernel
> 3.11-rc2+ on a machine with 4TB memory, here is testing results:
> 
> Test environment:
> Machine: HP ProLiant DL980 G7 with 4TB RAM.
> CPU: Intel(R) Xeon(R) CPU E7- 2860  @ 2.27GHz (8 sockets, 10 cores)
> (Only 1 CPU was enabled the 2nd kernel)
> Kernel: 3.11.0-rc2+ (at patch b3a3a9c441e2c8f6b6760de9331023a7906a4ac6)
> crashkernel=384MB
> vmcore size: 4.0TB
> Dump file size: 15GB
> All measured time from debug message of makedumpfile.
> As a comparison, I also have tested makedumpfile 1.5.3.
> 
> (all time in seconds)
>                      Excluding pages   Copy data   Total
> makedumpfile 1.5.3          468         1182       1650
> makedumpfile 1.5.4           93          518        611
> 
> 
> So it seems there is a great performance improvement by the mmap mechanism.

[CC Andrew].

Thanks Jingbai for testing results. Good to see that vmcore mmap() patches
are helping.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

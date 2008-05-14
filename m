Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24] helo=imx2.toshiba.co.jp)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Jw995-0006CM-Bg
	for kexec@lists.infradead.org; Wed, 14 May 2008 05:03:20 +0000
From: "gib" <suchada.pitchayasamanya@toshiba.co.jp>
References: <200804210517.m3L5Hq61011769@toshiba.co.jp>
	<480D790D.7080403@in.ibm.com>
	<200804230041.m3N0fIQD013543@toshiba.co.jp>
	<480F05D7.1060402@in.ibm.com>
	<200805090406.m4946FxB003919@toshiba.co.jp>
	<482A69C5.3060106@in.ibm.com>
In-Reply-To: <482A69C5.3060106@in.ibm.com>
Subject: RE: Question about forcing kernel panic on PowerMac G5 by kexec
	command
Date: Wed, 14 May 2008 14:02:54 +0900
Message-Id: <200805140502.m4E52udd015629@toshiba.co.jp>
MIME-Version: 1.0
Content-Language: ja
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: 'Mohan Kumar M' <mohan@in.ibm.com>
Cc: kexec@lists.infradead.org

Hi Mohan,

> Do you have only one entry for memory node in the /proc/device-tree
directory?
Yes, I have only one entry(for memory) in the /proc/device-tree directory.

> Do you know last good working version of kernel (for kdump) and try to 
> boot into that kernel and check the memory nodes in device-tree?
What is the last version of kernel for kdump which you mentioned?
(now I using the vanilla kernel 2.6.25 version)

Please tell me and I will try to boot into it.

Thank you,
Suchada

-----Original Message-----
From: Mohan Kumar M [mailto:mohan@in.ibm.com] 
Sent: Wednesday, May 14, 2008 1:26 PM
To: gib
Cc: kexec@lists.infradead.org
Subject: Re: Question about forcing kernel panic on PowerMac G5 by kexec
command

gib wrote:
> Hi Mohan,
> 
> Sorry for the late reply.
> 
>> I am not sure about the latest kexec tools. Is it possible to test with 
>> the kexec-tools shipped with the distro?
> 
> I tried to test with the kexec-tools shipped with the distro before and it
> gave me the same result as the latest kexec-tools (kexec-tools-testing
> 20080324).
> 
>> Can you give us the contents of the reg property in the last memory node 
>> in device tree?
> 
> With the command # hexdump /proc/device-tree/memory@0,0/reg I got
> 0000000 0000 0000 0000 0000 2000 0000 0000 0000
> 0000010 0000 0000 0000 0000 0000 0000 2000 0000
> 0000020 2000 0000 0000 0000 4000 0000 2000 0000
> 0000030 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0000060
> 

Hi Suchada,

Do you have only one entry for memory node in the /proc/device-tree 
directory?

Do you know last good working version of kernel (for kdump) and try to 
boot into that kernel and check the memory nodes in device-tree?

kexec-tools uses reg property in the memory device nodes to calculate 
the total system memory.

 From above "hexdump", I could not parse the memory properties.

Regards,
Mohan.


> Is it because of this problem that cause the system did not go the next
step
> and kept showing "Sending IPI to other CPU" message?
> 
> Thanks for your help,
> Suchada
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

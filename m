Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from imx12.toshiba.co.jp ([61.202.160.132])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K1Vn1-0000xH-4o
	for kexec@lists.infradead.org; Thu, 29 May 2008 00:14:43 +0000
From: "gib" <suchada.pitchayasamanya@toshiba.co.jp>
References: <200804210517.m3L5Hq61011769@toshiba.co.jp>
	<480D790D.7080403@in.ibm.com>
	<200804230041.m3N0fIQD013543@toshiba.co.jp>
	<480F05D7.1060402@in.ibm.com>
	<200805090406.m4946FxB003919@toshiba.co.jp>
	<482A69C5.3060106@in.ibm.com>
	<200805140502.m4E52udd015629@toshiba.co.jp>
	<48342A82.2000706@in.ibm.com> <483688A6.1080601@in.ibm.com>
In-Reply-To: <483688A6.1080601@in.ibm.com>
Subject: RE: Question about forcing kernel panic on PowerMac G5 by kexec
	command
Date: Thu, 29 May 2008 09:14:32 +0900
Message-Id: <200805290014.m4T0EWX5001220@toshiba.co.jp>
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

> Is there any node called "ibm,dynamic-reconfiguration-memory" in the 
> device tree?
There is no any node called "ibm,dynamic-reconfiguration-memory" in my
PowerMac G5.
What is the mentioned node (ibm,dynamic-reconfiguration-memory) responsible
for?

Regards,
Suchada

-----Original Message-----
From: Mohan Kumar M [mailto:mohan@in.ibm.com] 
Sent: Friday, May 23, 2008 6:05 PM
To: gib
Cc: kexec@lists.infradead.org
Subject: Re: Question about forcing kernel panic on PowerMac G5 by kexec
command

Mohan Kumar M wrote:
> gib wrote:
>> Hi Mohan,
>>
>>> Do you have only one entry for memory node in the /proc/device-tree
>> directory?
>> Yes, I have only one entry(for memory) in the /proc/device-tree
directory.
>>
>>> Do you know last good working version of kernel (for kdump) and try to 
>>> boot into that kernel and check the memory nodes in device-tree?
>> What is the last version of kernel for kdump which you mentioned?
>> (now I using the vanilla kernel 2.6.25 version)
> 
> Hi Suchada,
> 
> Sorry, I don't have information related to G5 and kexec/kdump. Still I 
> am not sure why the device tree is exporting only one memory node.

Hi Suchada,

Is there any node called "ibm,dynamic-reconfiguration-memory" in the 
device tree?

Regards,
Mohan.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

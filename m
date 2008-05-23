Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JzTCc-00033f-SK
	for kexec@lists.infradead.org; Fri, 23 May 2008 09:04:43 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4N94gZD021416
	for <kexec@lists.infradead.org>; Fri, 23 May 2008 05:04:42 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4N94gZJ153520
	for <kexec@lists.infradead.org>; Fri, 23 May 2008 05:04:42 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4N94f4g003369
	for <kexec@lists.infradead.org>; Fri, 23 May 2008 05:04:41 -0400
Message-ID: <483688A6.1080601@in.ibm.com>
Date: Fri, 23 May 2008 14:34:38 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: Question about forcing kernel panic on PowerMac G5 by kexec
	command
References: <200804210517.m3L5Hq61011769@toshiba.co.jp>
	<480D790D.7080403@in.ibm.com>
	<200804230041.m3N0fIQD013543@toshiba.co.jp>
	<480F05D7.1060402@in.ibm.com>
	<200805090406.m4946FxB003919@toshiba.co.jp>
	<482A69C5.3060106@in.ibm.com>
	<200805140502.m4E52udd015629@toshiba.co.jp>
	<48342A82.2000706@in.ibm.com>
In-Reply-To: <48342A82.2000706@in.ibm.com>
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
To: gib <suchada.pitchayasamanya@toshiba.co.jp>
Cc: kexec@lists.infradead.org

Mohan Kumar M wrote:
> gib wrote:
>> Hi Mohan,
>>
>>> Do you have only one entry for memory node in the /proc/device-tree
>> directory?
>> Yes, I have only one entry(for memory) in the /proc/device-tree directory.
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

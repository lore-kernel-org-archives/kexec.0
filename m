Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Jw8Yl-0000WI-JB
	for kexec@lists.infradead.org; Wed, 14 May 2008 04:25:48 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4E4PiLx021165
	for <kexec@lists.infradead.org>; Wed, 14 May 2008 00:25:44 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4E4PiTP207118
	for <kexec@lists.infradead.org>; Tue, 13 May 2008 22:25:44 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4E4PiIg016473
	for <kexec@lists.infradead.org>; Tue, 13 May 2008 22:25:44 -0600
Message-ID: <482A69C5.3060106@in.ibm.com>
Date: Wed, 14 May 2008 09:55:41 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: Question about forcing kernel panic on PowerMac G5 by kexec
	command
References: <200804210517.m3L5Hq61011769@toshiba.co.jp>
	<480D790D.7080403@in.ibm.com>
	<200804230041.m3N0fIQD013543@toshiba.co.jp>
	<480F05D7.1060402@in.ibm.com>
	<200805090406.m4946FxB003919@toshiba.co.jp>
In-Reply-To: <200805090406.m4946FxB003919@toshiba.co.jp>
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


> Is it because of this problem that cause the system did not go the next step
> and kept showing "Sending IPI to other CPU" message?
> 
> Thanks for your help,
> Suchada
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

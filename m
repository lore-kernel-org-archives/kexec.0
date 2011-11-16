Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143])
 by merlin.infradead.org with smtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQfDt-0008QV-Sw
 for kexec@lists.infradead.org; Wed, 16 Nov 2011 13:08:19 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 316E23BC
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 13:08:08 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CD1DA4F9D
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 13:08:07 +0000 (GMT)
From: Angelo CASTELLO <angelo.castello@st.com>
Subject: problem on uImage-sh support.
Date: Wed, 16 Nov 2011 14:07:45 +0100
Message-ID: <001201cca460$c8425db0$58c71910$@castello@st.com>
MIME-Version: 1.0
Content-Language: en-us
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
To: kexec@lists.infradead.org
Cc: 'Angelo CASTELLO' <angelo.castello@st.com>

Hi all,
I tried to use the uImage-sh support but unfortunately it doesn't work.
I think to have found where is the fault that i want
discuss with all SH users.
The actual kexec code is expecting to have the kernel uImage as
uImage_header + zImage
but the actual build produces
uImage_header + vmlinux.bin.gz
So, the uImage_sh_load routine doesn't match with the input file.

Is there someone have met this problem ?

I rewritten the above mentioned routine using the generic uImage_gz_load and
all is working fine. 
Before the submit the patch your feedback is welcome.
Regards,
Angelo


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

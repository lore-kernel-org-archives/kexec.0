Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UnQyO-0003cl-DV
 for kexec@lists.infradead.org; Fri, 14 Jun 2013 10:11:13 +0000
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Fri, 14 Jun 2013 04:10:47 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 68A5F3E40042
 for <kexec@lists.infradead.org>; Fri, 14 Jun 2013 04:09:49 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5EAA65k152986
 for <kexec@lists.infradead.org>; Fri, 14 Jun 2013 04:10:06 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5EAA59Q026216
 for <kexec@lists.infradead.org>; Fri, 14 Jun 2013 04:10:05 -0600
Message-ID: <51BAEBFA.3080204@in.ibm.com>
Date: Fri, 14 Jun 2013 15:40:02 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Cross architecture analysis for Crash
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, crash-utiliy@redhat.com
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, anderson@redhat.com

Hi,

We have been working on enabling 'cross' analysis support for
Crash, where the target and the host differ in endian-ness.

For e.g, analysing a powerpc dump on an Intel box.

This would be useful for debugging the dumps captured on an
embedded board (say ppc44x), on a normal desktop PC(Intel based).

While the patches are being tested for 'Crash' utility we came
across a problem with the analysis of the compressed dump formats(aka 
diskdump). There is no information about the endian-ness of the dump
unlike the ELF format. Hence, we need to embed this information during
the makedumpfile processing of vmcores.

Here are some of the options we thought about :

1) Interpret the new_utsname.machine and decode the endian-ness/word
size.

2) Extend the signature string to contain information about the
endian-ness / word size.

	e.g, KDUMPB64 - for KDUMP, BigEndian 64bit

Since we don't know the endian-ness yet, we may not be able to use any
of the other fields which are 'int' or 'long' (e.g, status)

I am looking for suggestions or directions on the approach to add this
information.

Thanks
Suzuki




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

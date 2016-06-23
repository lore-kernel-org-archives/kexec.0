Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bGENO-0001yX-Tq
 for kexec@lists.infradead.org; Thu, 23 Jun 2016 23:49:39 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5NNnGAV122236
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 19:49:16 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23ra2mtt6t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 19:49:16 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 20:49:14 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id EC59C1DC006D
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 19:49:04 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5NNnCfC26935628
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 20:49:12 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5NNnBV8023503
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 20:49:12 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
Date: Thu, 23 Jun 2016 20:49:10 -0300
In-Reply-To: <576C63B4.8060302@gmail.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1612090.Qxo4UiJulB@hactar> <576C63B4.8060302@gmail.com>
MIME-Version: 1.0
Message-Id: <1489849.szMRu2Hvtq@hactar>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Am Freitag, 24 Juni 2016, 08:33:24 schrieb Balbir Singh:
> On 24/06/16 02:44, Thiago Jung Bauermann wrote:
> > Sorry, I still don't understand your concern. What kind of cheating?
> > Which values? If it's the values in the event log, there's no need to
> > trust the old kernel. The new kernel knows that the old kernel didn't
> > pass wrong measurement values in the event log because it can
> > recalculate the PCR extend operations recorded in the log and compare
> > the results of the replay with the current PCR values stored in the TPM
> > device. If they match, then the event log is guaranteed to be correct.
> > If they don't match, either the memory was corrupted somehow during the
> > kexec process, or the old kernel tried to pass a falsified event log.
> 
> Yep, get it/got it. My concern was anything using passed on the values
> should compare the results with the current PCR values.
> 
> BTW, what do we gain by passing the values if we are relying on the PCR
> registers anyway, can't we directly read them off from there? Aren't we
> going to ready anyway to compare, what does passing the values gain?

The PCR values themselves change for reasons that the application/user may 
not care about. For example, just changing the order in which measurements 
are made changes the final value of the PCR, even if all the measurements 
themselves don't change. And in current multi-processor machines this order 
does change at each boot, so you can't rely on two boots of the same machine 
with the same software to have the same PCR values.

Also, you may want to verify only the measurement of one of the components 
and not care about the other components.

With an event log, you can verify the checksum of each measured component 
individually, and the PCR value serves to confirm that the event log is 
correct. Just having the final PCR value without the event log, you don't 
know which measurements were made.

> >> and
> >> 
> >> How do we know the new kernel is safe to load - I guess via a signature
> >> that the new kernel is signed with (assuming it is present in the key
> >> ring).
> > 
> > Correct. That goal is met by signature verification, not by integrity
> > assurance.
> > 
> > I'll note that even with both of my patch series there's still code
> > missing for kernel signature verification in PowerPC. I believe there's
> > not a file format defined yet for how to store a signature in a PowerPC
> > kernel image.
> > 
> > Integrity assurance doesn't depend on kernel signature verification
> > though. There's value in both my patch series even without kernel
> > signature verification support. They're complementary features.
> 
> Thanks for clarifying

Thank you for your interest.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

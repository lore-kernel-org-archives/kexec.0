Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIXqO-0007o0-PA
 for kexec@lists.infradead.org; Wed, 16 Sep 2020 13:51:33 +0000
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08GDXDxY060102
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2020 09:51:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33kjmgjeaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2020 09:51:30 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08GDXkWF061587
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2020 09:51:28 -0400
From: Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH 1/1] Calculate offset to field 'init_uts_ns.name'
In-Reply-To: <CAFTCetT=6RZ4EMwKjx4p-SG=1xACfC-NVaFNq6KJonYaymWZVg@mail.gmail.com>
References: <20200916090821.929093-1-egorenar@linux.ibm.com>
 <CAFTCetT=6RZ4EMwKjx4p-SG=1xACfC-NVaFNq6KJonYaymWZVg@mail.gmail.com>
Date: Wed, 16 Sep 2020 15:51:22 +0200
Message-ID: <878sd96d9h.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
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
To: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Cc: , kexec@lists.infradead.org

Bhupesh SHARMA <bhupesh.linux@gmail.com> writes:


> I am not sure if it is an issue with my mail-client or if the
> indentation is a bit different from the original code (I see a
> additional space before the statement) [and likewise below].
>
> Please fix those..

Sorry, i do not see any spaces in my diffs, only tabs.

> Hmm.. don't we need a similar addition inside 'write_vmcoreinfo_data'.
> Something like:
> WRITE_MEMBER_OFFSET("init_uts_ns.name", init_uts_ns.name);
>

Fixed. Sorry. My first makedumpfile change, still new ;)

Regards
Alex

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

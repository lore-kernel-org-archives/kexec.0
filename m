Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icyE8-000778-KU
 for kexec@lists.infradead.org; Thu, 05 Dec 2019 20:59:58 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v4 0/4] makedumpfile/arm64: Add support for ARMv8.2
 extensions
Date: Thu, 5 Dec 2019 20:59:23 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035975DB@BPXM09GP.gisp.nec.co.jp>
References: <1573556939-17803-1-git-send-email-bhsharma@redhat.com>
 <CAJ2QiJJ6DdxFheRo78+n1=ZuqMQnHeuLVWchK8SApt3w9wBKLQ@mail.gmail.com>
 <B71B3868-9A0B-46AD-8777-97A1599BFB91@oracle.com>
 <CACi5LpOF2FLrmXEyJ4FfjqJBxxt-np2+1V0EFK__EH=6ubFE0A@mail.gmail.com>
 <276620F6-E9AC-4BC6-B413-D84677C3D6BC@oracle.com>
In-Reply-To: <276620F6-E9AC-4BC6-B413-D84677C3D6BC@oracle.com>
Content-Language: en-US
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
To: John Donnelly <john.p.donnelly@oracle.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>

> -----Original Message-----
> This is your makedumpfile pulled from sourceforge .
> 
> It would be helpful if you bumped the VERSION and DATE to be certain we are using the correct pieces .

Good suggestion.

I wanted the command line that executed makedumpfile in debug message
as well, so I'll think about adding them together.

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

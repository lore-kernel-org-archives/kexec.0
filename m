Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iK1h4-0001aD-EL
 for kexec@lists.infradead.org; Mon, 14 Oct 2019 14:51:31 +0000
Received: by mail-qt1-x844.google.com with SMTP id 3so25862240qta.1
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2019 07:51:29 -0700 (PDT)
Date: Mon, 14 Oct 2019 14:51:25 +0000
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v6 03/17] arm64: hibernate: check pgd table allocation
Message-ID: <20191014145125.ahemooviyznqgpdh@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-4-pasha.tatashin@soleen.com>
 <b5f965b5-bbd6-9e53-c085-d1a0c0dceca7@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b5f965b5-bbd6-9e53-c085-d1a0c0dceca7@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

> Thanks for splitting [0] into two ... but this fix depends on the previous patch - which
> isn't an issue that anyone can hit, and doesn't match Greg's 'stable-kernel-rules'.
> 
> Please separate out this patch - and post it on its own as a stand-alone fix that can be
> sent to the stable trees.
> 
> 
> Mixing fixes with other patches leads to problems like this. It isn't possible to pick
> this fix independently of the cleanup in the previous patch.

Thank you, I sent it out as a separate fix.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

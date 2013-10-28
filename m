Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vafk2-0003g8-IZ
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 05:51:54 +0000
Date: Mon, 28 Oct 2013 13:51:11 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86, kdump: crashkernel=X try to reserve below 896M
 first, then try below 4G, then MAXMEM
Message-ID: <20131028055111.GC20741@dhcp-16-126.nay.redhat.com>
References: <CAE9FiQWdMmSseDk6J=TOXT9ZahJUBf2BOU+VHJRXeeMofgH=EQ@mail.gmail.com>
 <20131021151643.GA20669@redhat.com>
 <CAE9FiQVfeUdugFRMt1DGjtqW2FAb2gfnGjXENHjoJ=JVAYbYgw@mail.gmail.com>
 <20131024140241.GA2322@redhat.com>
 <CAE9FiQUu0WwMgNpog4TKch+MT2i7_DsNvqZxbyQusS4AFxdhQQ@mail.gmail.com>
 <20131024191821.GE2322@redhat.com>
 <CAE9FiQU7+FRY=3ETdGZJJfcS0vjRht4ZT8MHTQ66kpjD2MmrcA@mail.gmail.com>
 <20131024192752.GG2322@redhat.com>
 <CAE9FiQUw6REg2TXnSXtNZK8XY9vnorvi8oDbUn_5WdNZ6yiRtQ@mail.gmail.com>
 <20131028054950.GB20741@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131028054950.GB20741@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Jacob Shin <jacob.shin@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, WANG Chao <chaowang@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On 10/28/13 at 01:49pm, Dave Young wrote:
> > without Cong's patch, kernel will fail to reserve, and user would dig
> 
> s/Chao/Cong ;)

s/Cong/Chao in fact :(

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

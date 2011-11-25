Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RTs8o-0001Sl-Aj
 for kexec@lists.infradead.org; Fri, 25 Nov 2011 09:32:19 +0000
Received: by iapp10 with SMTP id p10so4922535iap.36
 for <kexec@lists.infradead.org>; Fri, 25 Nov 2011 01:32:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111125081959.GA2505@darkstar.nay.redhat.com>
References: <20111125081959.GA2505@darkstar.nay.redhat.com>
Date: Fri, 25 Nov 2011 17:32:15 +0800
Message-ID: <CAM_iQpW7WXeUihgbJneJUJ1GAMzXfONfV69dpqeRbUt_781M=Q@mail.gmail.com>
Subject: Re: [PATCH] kexec: do not call kmsg_dump in crashdump
From: Cong Wang <xiyou.wangcong@gmail.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

On Fri, Nov 25, 2011 at 4:19 PM, Dave Young <dyoung@redhat.com> wrote:
> mtd/ram oops dumper will make more functions envolved. In case crash kexec,
> we should avoid kmsg dumper to ensure crashdump success.
>
> kill kmsg_dump callback while crash dumping

https://lkml.org/lkml/2011/2/1/33

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

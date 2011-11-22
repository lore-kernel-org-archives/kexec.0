Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vw0-f49.google.com ([209.85.212.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RSt4C-0000Zj-VL
 for kexec@lists.infradead.org; Tue, 22 Nov 2011 16:19:30 +0000
Received: by vbbfs19 with SMTP id fs19so414317vbb.36
 for <kexec@lists.infradead.org>; Tue, 22 Nov 2011 08:19:27 -0800 (PST)
Date: Tue, 22 Nov 2011 08:19:22 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: fix chunk range calculation
Message-ID: <20111122161922.GC3250@google.com>
References: <CAOS58YMOuJrvGxE1VxsU=ZPTLgY60HDJoLFjTowx9ZApUQ3tTw@mail.gmail.com>
 <4EC491B3.705@redhat.com>
 <CAMMEr5k_ynqg5-7Looar2DxXTGZcMqi5Lo+jtETn9awO_bsaGg@mail.gmail.com>
 <4EC4B60C.3030706@redhat.com> <1321548033.12208.12.camel@boudreau>
 <4EC61AB6.4090808@redhat.com> <4EC61B2A.7010000@redhat.com>
 <20111118185535.GA27152@google.com>
 <20111121211050.GK25776@google.com> <4ECB0D7C.1020700@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ECB0D7C.1020700@redhat.com>
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
Cc: WANG Cong <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, tim@edgecast.com, linux-kernel@vger.kernel.org

On Tue, Nov 22, 2011 at 10:48:28AM +0800, Dave Young wrote:
> Tested-by: Dave Young <dyoung@redhat.com>

Thanks.  Applied to percpu/for-3.2-fixes with Tested-by added.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

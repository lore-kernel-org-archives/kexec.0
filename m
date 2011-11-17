Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-fx0-f49.google.com ([209.85.161.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQtgO-00083w-6j
 for kexec@lists.infradead.org; Thu, 17 Nov 2011 04:34:40 +0000
Received: by faar25 with SMTP id r25so3081768faa.36
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 20:34:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EC47FCA.5090908@redhat.com>
References: <1318376345.2050.20.camel@boudreau> <j9r5m5$b18$1@dough.gmane.org>
 <1321296650.2066.17.camel@boudreau> <4EC21F67.10905@redhat.com>
 <1321396371.4198.5.camel@boudreau> <4EC31E55.6040809@redhat.com>
 <1321467647.2137.4.camel@boudreau> <4EC47FCA.5090908@redhat.com>
Date: Wed, 16 Nov 2011 20:34:36 -0800
Message-ID: <CAOS58YMOuJrvGxE1VxsU=ZPTLgY60HDJoLFjTowx9ZApUQ3tTw@mail.gmail.com>
Subject: Re: Crash during vmcore_init
From: Tejun Heo <tj@kernel.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, tim@edgecast.com, linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 16, 2011 at 7:30 PM, Dave Young <dyoung@redhat.com> wrote:
> This addr is converted to an invalid phys address,

I'm a bit lost on the context here. Who's calling per_cpu_ptr_to_phys()?

> looking the code below:
> =A0 =A0 =A0 if (in_first_chunk) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!is_vmalloc_addr(addr))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return __pa(addr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return page_to_phys(vmallo=
c_to_page(addr));
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return page_to_phys(pcpu_addr_to_page(addr=
));
>
> I dont understand per cpu allocation well, if addr is not in first chunk
> then it should be in vmalloc area?

Yes, it is. First chunk can be embedded in the kernel linear address
space but from the second one, it's always set up from the top of the
vmalloc area with the same offset layout as the first chunk.

> Tejun, do you have any idea about this?

Can you please tell me how to reproduce the problem? I'll try to find
out what's going on.

Thanks.

-- =

tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

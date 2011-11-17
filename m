Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-fx0-f49.google.com ([209.85.161.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQwJX-0003AC-Gz
 for kexec@lists.infradead.org; Thu, 17 Nov 2011 07:23:16 +0000
Received: by faar25 with SMTP id r25so3171260faa.36
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 23:23:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EC4B60C.3030706@redhat.com>
References: <1318376345.2050.20.camel@boudreau> <j9r5m5$b18$1@dough.gmane.org>
 <1321296650.2066.17.camel@boudreau> <4EC21F67.10905@redhat.com>
 <1321396371.4198.5.camel@boudreau> <4EC31E55.6040809@redhat.com>
 <1321467647.2137.4.camel@boudreau> <4EC47FCA.5090908@redhat.com>
 <CAOS58YMOuJrvGxE1VxsU=ZPTLgY60HDJoLFjTowx9ZApUQ3tTw@mail.gmail.com>
 <4EC491B3.705@redhat.com>
 <CAMMEr5k_ynqg5-7Looar2DxXTGZcMqi5Lo+jtETn9awO_bsaGg@mail.gmail.com>
 <4EC4B60C.3030706@redhat.com>
Date: Wed, 16 Nov 2011 23:23:13 -0800
Message-ID: <CAOS58YN19wnvKtExyvPrtrQQDp7fnJc0jWHx9oapADwtipaJDQ@mail.gmail.com>
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
Cc: WANG Cong <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, Tim Hartrick <tim@edgecast.com>, linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 16, 2011 at 11:21 PM, Dave Young <dyoung@redhat.com> wrote:
>> I will be happy to answer any questions about our environment or test
>> debug or other patches. =A0Just tell me what you need.
>
>
> Thank you. Can you share your kernel config?

Yes, please, I'm wondering whether PER_CPU_KM is in use.

Thanks.

-- =

tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ob0-x233.google.com ([2607:f8b0:4003:c01::233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VHJT6-0007L3-Fc
 for kexec@lists.infradead.org; Wed, 04 Sep 2013 20:14:25 +0000
Received: by mail-ob0-f179.google.com with SMTP id fb19so946671obc.38
 for <kexec@lists.infradead.org>; Wed, 04 Sep 2013 13:14:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130904200959.GE8540@anatevka.fc.hp.com>
References: <1378252218-18798-1-git-send-email-matthew.garrett@nebula.com>
 <1378252218-18798-9-git-send-email-matthew.garrett@nebula.com>
 <20130904200959.GE8540@anatevka.fc.hp.com>
Date: Wed, 4 Sep 2013 16:14:00 -0400
Message-ID: <CA+5PVA6HayQJEDFisvXYJKyoKDbJh53fWki=Arbn_9t=NppGrw@mail.gmail.com>
Subject: Re: [PATCH V3 08/11] kexec: Disable at runtime if the kernel enforces
 module loading restrictions
From: Josh Boyer <jwboyer@fedoraproject.org>
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
To: jerry.hoemann@hp.com
Cc: Matthew Garrett <matthew.garrett@nebula.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Kees Cook <keescook@chromium.org>, kexec <kexec@lists.infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Sep 4, 2013 at 4:09 PM,  <jerry.hoemann@hp.com> wrote:
> On Tue, Sep 03, 2013 at 07:50:15PM -0400, Matthew Garrett wrote:
>> kexec permits the loading and execution of arbitrary code in ring 0, which
>> is something that module signing enforcement is meant to prevent. It makes
>> sense to disable kexec in this situation.
>>
>> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
>
>
> Matthew,
>
> Disabling kexec will disable kdump, correct?

Yes.

> Are there plans to enable kdump on a system where secure
> boot is enabled?

Vivek Goyal has been working on this.  I've not seen the code yet, but
I believe it should be posted somewhere relatively soon.  We're also
planning on talking about it at the Secure Boot microconference at
Linux Plumbers in two weeks.

josh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

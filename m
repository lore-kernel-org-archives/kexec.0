Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ob0-x22a.google.com ([2607:f8b0:4003:c01::22a])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V6k5f-0002hY-Cr
 for kexec@lists.infradead.org; Tue, 06 Aug 2013 16:26:32 +0000
Received: by mail-ob0-f170.google.com with SMTP id eh20so1355144obb.29
 for <kexec@lists.infradead.org>; Tue, 06 Aug 2013 09:26:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5200BFB3.2050202@jp.fujitsu.com>
References: <5200BFB3.2050202@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 6 Aug 2013 10:25:48 -0600
Message-ID: <CAErSpo5O8RbL=h5jrD3NkBhH6ARhMOag9JfUzPEED0cBfDSwxQ@mail.gmail.com>
Subject: Re: [Help Test] kdump, x86, acpi: Reproduce CPU0 SMI corruption issue
 after unsetting BSP flag
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, jingbai.ma@hp.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Aug 6, 2013 at 3:19 AM, HATAYAMA Daisuke
<d.hatayama@jp.fujitsu.com> wrote:
> So, could anyone help testing the idea 2) above if you have which of
> the following machines? (or other ones that can lead to the same bug)
>
> - HP Compaq 6910p
> - HP Compaq 6710b
> - HP Compaq 6710s
> - HP Compaq 6510b
> - HP Compaq 2510p

Sorry, I don't have access to any of these machines any more, and I
don't have any useful advice for you.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

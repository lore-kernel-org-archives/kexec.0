Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bzOdk-0007J6-Hb
 for kexec@lists.infradead.org; Wed, 26 Oct 2016 13:53:13 +0000
Received: by mail-oi0-x22c.google.com with SMTP id n202so17654119oig.3
 for <kexec@lists.infradead.org>; Wed, 26 Oct 2016 06:52:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3118d747-8f11-fae5-9541-0fb0917eaa14@infradead.org>
References: <CAKYm0coteEEapCNwmj+KmGd57C_C3--nXQfjyD_FLoGXSkqMkQ@mail.gmail.com>
 <3118d747-8f11-fae5-9541-0fb0917eaa14@infradead.org>
From: Simon T <smith.not.western@gmail.com>
Date: Wed, 26 Oct 2016 14:52:50 +0100
Message-ID: <CAKYm0crtFkPh5iu3LNBZniFGNT2Xc0=WKO+=5_H_t+2+jNCBcw@mail.gmail.com>
Subject: Re: kexec and arm64 advice
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org

On Tue, Oct 25, 2016 at 5:57 PM, Geoff Levand <geoff@infradead.org> wrote:
> On 10/24/2016 07:42 AM, Simon T wrote:
>> Both tools and kernel appear to build fine, however when it
>> comes time to kexec, I encounter this message: "kexec_load failed:
>> Function not implemented"
>
> It seems your kernel needs kexec support. Try something like:
>
>   cat /proc/config.gz | gunzip | egrep 'KEXEC'

Aha, yes you are correct it is not compiled in, even though it was in
my .config. I will investigate my config files and build scripts
further,

Thanks,

Simon

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

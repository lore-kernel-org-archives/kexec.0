Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x236.google.com ([2607:f8b0:4001:c03::236])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UmcSH-0003rs-BR
 for kexec@lists.infradead.org; Wed, 12 Jun 2013 04:14:42 +0000
Received: by mail-ie0-f182.google.com with SMTP id s9so7357789iec.41
 for <kexec@lists.infradead.org>; Tue, 11 Jun 2013 21:14:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWaAqGi5iGj+=ET4_D3OxuSjpHpMKAmOk--YHXMx_wJ-A@mail.gmail.com>
References: <E1UmXSQ-0008Nq-27@eag09.americas.sgi.com>
 <CAE9FiQWaAqGi5iGj+=ET4_D3OxuSjpHpMKAmOk--YHXMx_wJ-A@mail.gmail.com>
Date: Tue, 11 Jun 2013 21:14:19 -0700
Message-ID: <CAE9FiQXPk8ix36MByC5GJrV5eE4ApPHBzKVSJqOqc+vG4eKqUA@mail.gmail.com>
Subject: Re: kexec: purgatory hang
From: Yinghai Lu <yinghai@kernel.org>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Jun 11, 2013 at 6:45 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Jun 11, 2013 at 3:54 PM, Cliff Wickman <cpw@sgi.com> wrote:
>>
>> I'm getting a hang when trying to enter a high-memory crash kernel,
>> and I'm at a loss as to how to debug this.
>>
>> This is a 3.10.0-rc3 kernel, and set up as the crash kernel by kexec 2.0.4.
>> The machine is an SGI UV1000.
>
> what is your mem size?

also can you post your /proc/iomem in first kernel?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

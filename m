Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fQKPd-0001nq-AZ
 for kexec@lists.infradead.org; Tue, 05 Jun 2018 22:26:47 +0000
Received: by mail-vk0-x243.google.com with SMTP id q135-v6so2476001vkh.1
 for <kexec@lists.infradead.org>; Tue, 05 Jun 2018 15:26:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1528234513.3557.16.camel@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
 <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
 <1527635645.3534.39.camel@linux.vnet.ibm.com>
 <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
 <1527780226.3427.20.camel@linux.vnet.ibm.com>
 <CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
 <1528234513.3557.16.camel@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 15:26:32 -0700
Message-ID: <CAGXu5j+9P9HLvwC4WfHoxXsz7vYA_raStVDPzA=tNR9f9vr9=Q@mail.gmail.com>
Subject: Re: [PATCH v4a 8/8] module: replace the existing LSM hook in
 init_module
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, "Luis R . Rodriguez" <mcgrof@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jeff Vander Stoep <jeffv@google.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity <linux-integrity@vger.kernel.org>, James Morris <jmorris@namei.org>, Andres Rodriguez <andresx7@gmail.com>

On Tue, Jun 5, 2018 at 2:35 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2018-06-05 at 12:45 -0700, Kees Cook wrote:
>
>> And if you must have a separate enum, please change this to fail
>> closed instead of open (and mark the fall-through):
>>
>> int rc = -EPERM;
>>
>> switch (id) {
>> case LOADING_MODULE:
>>     rc = loadpin_read_file(NULL, READING_MODULE);
>>     /* Fall-through */
>> default:
>>     break;
>> }
>
> This will fail the sysfs firmware fallback loading and the kexec_load
> syscall without any message, as you have for init_module.  Is that
> what you want?

I'd prefer there be a full mapping of the enums so that everything
gets passed into loadpin_read_file() :)

Can the enum be shared or is that nonsensical?

-Kees

-- 
Kees Cook
Pixel Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

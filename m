Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fQAwV-00056L-Gh
 for kexec@lists.infradead.org; Tue, 05 Jun 2018 12:20:05 +0000
Received: by mail-ua0-x244.google.com with SMTP id m21-v6so1463279uan.0
 for <kexec@lists.infradead.org>; Tue, 05 Jun 2018 05:19:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605040920.GA19747@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1528121025.3237.116.camel@linux.vnet.ibm.com>
 <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
 <20180605040920.GA19747@mail.hallyn.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 05:19:50 -0700
Message-ID: <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
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
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andres Rodriguez <andresx7@gmail.com>, Paul Moore <paul@paul-moore.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, "Luis R . Rodriguez" <mcgrof@kernel.org>, James Morris <james.l.morris@oracle.com>, Jessica Yu <jeyu@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity <linux-integrity@vger.kernel.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Eric Biederman <ebiederm@xmission.com>

On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Personally I agree with Eric and prefer a new hook.  I don't feel strongly
> enough about it to keep bikeshedding, but since this set already exists,
> it seems like the way to go.

And the new hook is "load stuff without a file descriptor"?

-Kees

-- 
Kees Cook
Pixel Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fQCbT-0005n0-C7
 for kexec@lists.infradead.org; Tue, 05 Jun 2018 14:06:28 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w55Dx8oI121927
 for <kexec@lists.infradead.org>; Tue, 5 Jun 2018 10:06:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jdu8mafvm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 05 Jun 2018 10:06:10 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 5 Jun 2018 15:06:08 +0100
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 05 Jun 2018 10:05:49 -0400
In-Reply-To: <CAGXu5j+vsYHBpH75i=GxVfi0HgvsAW6zgz6V-eO8ZD13ykq2mw@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1528121025.3237.116.camel@linux.vnet.ibm.com>
 <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
 <20180605040920.GA19747@mail.hallyn.com>
 <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
 <20180605132542.GA26722@mail.hallyn.com>
 <CAGXu5j+vsYHBpH75i=GxVfi0HgvsAW6zgz6V-eO8ZD13ykq2mw@mail.gmail.com>
Mime-Version: 1.0
Message-Id: <1528207549.3237.149.camel@linux.vnet.ibm.com>
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
To: Kees Cook <keescook@chromium.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andres Rodriguez <andresx7@gmail.com>, Paul Moore <paul@paul-moore.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, "Luis
 R . Rodriguez" <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity <linux-integrity@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>

On Tue, 2018-06-05 at 06:43 -0700, Kees Cook wrote:
> On Tue, Jun 5, 2018 at 6:25 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > Quoting Kees Cook (keescook@chromium.org):
> >> On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> >> > Personally I agree with Eric and prefer a new hook.  I don't feel strongly
> >> > enough about it to keep bikeshedding, but since this set already exists,
> >> > it seems like the way to go.
> >>
> >> And the new hook is "load stuff without a file descriptor"?
> >
> > Yes.  Load stuff based on my own credentials not those attached
> > to a file.
> 
> Okay, I can live with that. :)

Can I get your Ack on the loadpin changes in v4a patch 8/8?

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

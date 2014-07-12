Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1405124388.4264.23.camel@smoke>
Subject: Re: Kexec on arm64
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 11 Jul 2014 17:19:48 -0700
In-Reply-To: <CAFdej00cCymXM1wu31X7p6_Njy9sL-c7+k-v-+5jrmAuozsMng@mail.gmail.com>
References: <CAFdej01jQFS3MrSdiQCWwv36qzG4L301w0iNJgGeunt-_44okA@mail.gmail.com>
 <CAFdej03ziTTA5QGFjzKd6Kc4skWNTr5RECy69qtnQGVtE6ks3w@mail.gmail.com>
 <1404931759.26155.70.camel@smoke>
 <CAFdej00cCymXM1wu31X7p6_Njy9sL-c7+k-v-+5jrmAuozsMng@mail.gmail.com>
Mime-Version: 1.0
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
To: Arun Chandran <achandran@mvista.com>
Cc: kexec@lists.infradead.org

Hi Arun,

On Fri, 2014-07-11 at 16:56 +0530, Arun Chandran wrote:
> The below code fixes that issue (missing null check.

I just pushed out a fix for this, slightly different
from yours.  Please let me know if you still have a
problem with it.

-Geoff 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

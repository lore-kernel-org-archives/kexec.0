Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-ID: <1386876601.1002.0.camel@smoke>
Subject: Re: [PATCH 4/4] sh/kexec: Fix kexec build warning
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 12 Dec 2013 11:30:01 -0800
In-Reply-To: <CAMuHMdUVfY5UO2tZEzSML9Bhx64VobDdyJQwOgfQ5=2wzxbONQ@mail.gmail.com>
References: <cover.1386807069.git.geoff@infradead.org>
 <594a3d26aac66e9668edc81d7bfb4e801575514f.1386807069.git.geoff@infradead.org>
 <CAMuHMdUVfY5UO2tZEzSML9Bhx64VobDdyJQwOgfQ5=2wzxbONQ@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mundt <lethal@linux-sh.org>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi,

On Thu, 2013-12-12 at 15:48 +0100, Geert Uytterhoeven wrote:
> On Thu, Dec 12, 2013 at 1:18 AM, Geoff Levand <geoff@infradead.org> wrote:
> > -                                    image->segment[i].memsz,
> > +                      (unsigned int)image->segment[i].memsz,e->start);
> 
> Wouldn't it be better to remove all casts and correct the printf-style
> format specifiers instead?

That would be better, I'll make a new patch.

Thanks Geert!



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

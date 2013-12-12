Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-ID: <1386876830.1002.4.camel@smoke>
Subject: Re: [PATCH 2/4] kexec: Add IND_FLAGS macro
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 12 Dec 2013 11:33:50 -0800
In-Reply-To: <52A912E3.1060802@cn.fujitsu.com>
References: <cover.1386807069.git.geoff@infradead.org>
 <3d9d024551c3c0e560d77f81926cb5774dda7067.1386807069.git.geoff@infradead.org>
 <52A912E3.1060802@cn.fujitsu.com>
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Paul Mackerras <paulus@samba.org>

Hi Zhang,

On Thu, 2013-12-12 at 09:35 +0800, Zhang Yanfei wrote:
> On 12/12/2013 08:18 AM, Geoff Levand wrote:
> > Add a new kexec preprocessor macro IND_FLAGS, which is the bitwise OR of
> > all the possible kexec IND_ kimage_entry indirection flags.
> > 
> > Having this macro allows for simplified code in the prosessing of the
> > kexec kimage_entry items.
> 
> Where? I didn't see any place you use this macro to help simplification.

As in powerpc, it allows constructions like this:

  switch (entry & IND_FLAGS) {
  case IND_DESTINATION:
  ...
  case IND_INDIRECTION:
  ...
  }

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

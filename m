Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KUyt0-00028J-22
	for kexec@lists.infradead.org; Mon, 18 Aug 2008 07:10:42 +0000
Date: Mon, 18 Aug 2008 17:10:39 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Explicitly use BUILD_CC and TARGET_CC
Message-ID: <20080818071037.GA5029@verge.net.au>
References: <1219030410.884068.167991623519.1.gpush@pingu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1219030410.884068.167991623519.1.gpush@pingu>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jeremy Kerr <jk@ozlabs.org>
Cc: kexec@lists.infradead.org

On Mon, Aug 18, 2008 at 11:33:30AM +0800, Jeremy Kerr wrote:
> Currently, we override CC for build and target compiles:
> 
> $(BIN_TO_HEX): CC=$(BUILD_CC)
> 
> However, this breaks when a user does something like:
> 
>  make CC=host-arch-gcc
> 
> - since command-line parameter overrides all makefile variables, so
> we end up using host-arch-gcc for *all* compiles, including those for
> target and build.
> 
> This change explicitly uses BUILD_CC and TARGET_CC where necessary,
> so that the CC variable isn't used for build and target compiles.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Hi Jeremy,

Unfortunately I have stumbled upon a couple of problems with
this patch.

> ---
>  purgatory/Makefile |   16 +++++++++-------
>  util/Makefile      |    6 +-----
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/purgatory/Makefile b/purgatory/Makefile
> index ac58719..d7aec3a 100644
> --- a/purgatory/Makefile
> +++ b/purgatory/Makefile
> @@ -42,27 +42,29 @@ purgatory/sha256.o: CFLAGS += -O0
>  
>  purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
>  	mkdir -p $(@D)
> -	$(COMPILE.c) -o $@ $^
> +	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_CPPFLAGS) -o $@ $^

This target is now duplicated by $(PURGATORY_OBJS): %.o: %.c below

>  
> -$(PURGATORY): CC=$(TARGET_CC)
> -$(PURGATORY): CFLAGS+=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
> +$(PURGATORY): TARGET_CFLAGS += $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
>  		      -Os -fno-builtin -ffreestanding \
>  		      -fno-zero-initialized-in-bss
>  
> -$(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
> +$(PURGATORY): TARGET_CPPFLAGS += $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
>  			-I$(srcdir)/purgatory/include \
>  			-I$(srcdir)/purgatory/arch/$(ARCH)/include \
>  			-I$(srcdir)/util_lib/include \
>  			-I$(shell $(CC) -print-file-name=include)
> -$(PURGATORY): LDFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS)\
> +
> +$(PURGATORY): TARGET_LDFLAGS += $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
>  			--no-undefined -nostartfiles -nostdlib -nodefaultlibs \
>  			-e purgatory_start -r
>  
>  $(PURGATORY): $(PURGATORY_OBJS)
>  	$(MKDIR) -p $(@D)
> -	$(CC) $(LDFLAGS) -o $@ $^
> +	$(TARGET_CC) $(TARGET_LDFLAGS) -o $@ $^
>  
> -#	$(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) --no-undefined -e purgatory_start -r -o $@ $(PURGATORY_OBJS) $(UTIL_LIB)
> +$(PURGATORY_OBJS): %.o: %.c

On some architectures, such as ia64, PURGATORY_SRCS can include .S files.
Prehaps we need PURGATORY_C_SRCS and PURGATORY_ASM_SRCS ?

> +	$(MKDIR) -p $(@D)
> +	$(TARGET_CC) $(TARGET_CPPFLAGS) $(TARGET_CFLAGS) -o $@ $^

I think that you need $(TARGET_CC) -c here.
Also above for purgatory/sha256.o if that target is to remain separate.

>  
>  echo::
>  	@echo "PURGATORY_SRCS $(PURGATORY_SRCS)"
> diff --git a/util/Makefile b/util/Makefile
> index 948ee63..9c005d5 100644
> --- a/util/Makefile
> +++ b/util/Makefile
> @@ -2,11 +2,7 @@ BIN_TO_HEX:= bin/bin-to-hex
>  
>  $(BIN_TO_HEX): $(srcdir)/util/bin-to-hex.c
>  	@$(MKDIR) -p $(@D)
> -	$(LINK.o) $(CFLAGS) -o $@ $^
> -
> -$(BIN_TO_HEX): CC=$(BUILD_CC)
> -$(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
> -$(BIN_TO_HEX): LDFLAGS=
> +	$(BUILD_CC) $(BUILD_CPPFLAGS) $(BUILD_CFLAGS) -o $@ $^
>  
>  dist += util/Makefile util/bin-to-hex.c
>  clean += util/bin-to-hex.o $(BIN_TO_HEX)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
